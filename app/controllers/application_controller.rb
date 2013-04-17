class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :redirect_if_not_canonical_host
  before_filter :authenticate_user!, :if => :authenticate? # devise

  # Exception handlers
  rescue_from StandardError, :with => :handle_exception

  protected
    # Global exception handler
    def handle_exception(exception)
      # See if this is an error we know about that should generate a message for the user
      msg = nil
      if defined?(CanCan) && exception.instance_of?(CanCan::AccessDenied)
        msg = "You are not authorized to perform this action. This request has been logged. Please, no tomfoolery." 
      end

      # Log exception
      logger.error "Exception: #{exception.inspect}; user_id = #{authenticate? && user_signed_in? ? current_user.id : '<none>'}; remote_ip = #{request.remote_ip}"

      # Clear render state to avoid 'double render' errors
      @_response_body = nil

      # Ajax requests get an error message to display, others get redirected to error page
      if request.xhr?
        render :json => {:error_msg => msg}, :status => 500
      else
        if msg.nil?
          redirect_to '/500.html'
        else
          flash[:alert] = msg
          redirect_to root_path
        end
      end

      # Raise it so exception notifier gets triggered
      raise exception
    end

    # Redirect to canonical hostname in production mode
    def redirect_if_not_canonical_host
      # Redirect if it doesn't match
      canonical_host = Rails.configuration.canonical_host
      if request.get? && Rails.env.production? && request.host != canonical_host
        redirect_to request.url.gsub(/#{request.host}/, canonical_host)
      end
    end

    # Helper to get permitted params
    def permitted_params
      @permitted_params ||= PermittedParams.new(params, current_user)
    end
    helper_method :permitted_params
    
    # Should we authenticate?
    def authenticate?
      # Don't try to authenticate unless we've set up devise
      return false unless defined?(current_user)

      # Devise doesn't need any authentication because it is responsible for authentication!
      # Active admin doesn't either because it has its own before_filter to only allow admin users.
      !devise_controller? && !admin_controller?
    end

    # Are we in active_admin?
    def admin_controller?
      defined?(ActiveAdmin) && self.kind_of?(ActiveAdmin::BaseController)
    end
end

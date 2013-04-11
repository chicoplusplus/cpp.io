class RegistrationsController < Devise::RegistrationsController
  respond_to :js, :html

  # Overriden from devise to allow update without password in certain cases
  # and to support js response
  def update
    # Get resource
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    # See if we should require user to enter their current password (currently only when changing password)
    whitelisted_params = resource_params
    password_required = !whitelisted_params[:password].blank?

    # Update resource
    update_successful = if password_required
      resource.update_with_password(whitelisted_params)
    else
      whitelisted_params.delete(:current_password) # remove in case it was entered
      resource.update_without_password(whitelisted_params)
    end

    # Respond
    if update_successful
      # Set flash message
      if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
        set_flash_message :notice, :update_needs_confirmation
      elsif !request.xhr?
        set_flash_message :notice, :updated
      end

      # Sign in, in case password changed
      sign_in resource_name, resource, :bypass => true

      # Respond
      if !request.xhr?
        respond_with resource, :location => after_update_path_for(resource)
      else
        respond_with resource, :layout => false
      end
    else
      clean_up_passwords resource
      respond_with resource, :layout => !request.xhr?
    end
  end

  protected
    # Override destination after update
    def after_update_path_for(user)
      edit_user_registration_path
    end

    # Change redirect after signing up
    def after_inactive_sign_up_path_for(user)
      user.confirmed_at.nil? ? new_user_session_path : edit_user_registration_path
    end

  private
    # Get whitelisted params for this resource
    def resource_params
      permitted_params.send(resource_name.to_sym)
    end
end

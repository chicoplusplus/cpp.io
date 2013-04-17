module ApplicationHelper
  def controller_stylesheet
    css = ""
    if File.exists?(Rails.root.join("app", "assets", "stylesheets", "#{controller.controller_name}.css.scss"))
      css = stylesheet_link_tag controller.controller_name
    end
    css
  end
  
  def controller_javascript
    js = ""
    if File.exists?(Rails.root.join("app", "assets", "javascripts", "#{controller.controller_name}.js"))
      js = javascript_include_tag controller.controller_name
    end
    js
  end

  def flashes?
    alerts = [:success, :notice, :alert]
    (defined?(Devise) && devise_controller? && !resource.errors.empty?) || alerts.any? {|a| flash[a] || flash.now[a]}
  end
  
  def standard_flashes()
    # Special hook for devise. Devise will do model validation, but doesn't stuff errors
    # in the flash object, so do that here
    if defined?(Devise) && devise_controller? && !resource.errors.empty?
      flash.now[:alert] = "There was a problem with the information you submitted. Please correct the information below and try again."
    end
    
    # Build flash divs
    flashes = ''
    flashes += flash_div(flash[:success], 'success') if flash[:success]
    flashes += flash_div(flash[:notice], 'secondary') if flash[:notice]
    flashes += flash_div(flash[:alert], 'alert') if flash[:alert]
    flashes.html_safe
  end
  
  def flash_div(msg, type)
    icons = {
      'success' => 'ok',
      'alert' => 'warning-sign',
      'secondary' => 'info-sign'
    }

    flashes = ''
    flashes += "<div class=\"alert-box #{type}\" style=\"display:none\">"
    flashes += "<h1><i class=\"icon-#{icons[type]}\"></i></h1>"
    flashes += "<p>#{msg}</p>"
    flashes += '<a href="#" class="close"><i class="icon-remove"></i></a>'
    flashes += '<div class="clear"></div>'
    flashes += '</div>'
    flashes
  end

  def round(value, round_to = 1.0)
    mod = value % round_to
    rounded = value - mod + (mod >= round_to/2.0 ? round_to : 0)
    rounded % 1 == 0 ? rounded.to_i : rounded
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true, :filter_html => true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      lax_spacing: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

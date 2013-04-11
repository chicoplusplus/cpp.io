class HomeController < ApplicationController
  # Cancan authorization
  authorize_resource

  def index; end

end


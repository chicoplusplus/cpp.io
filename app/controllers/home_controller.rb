class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  # Cancan authorization
  skip_authorization_check

  def index; end

  def about; end
  def terms; end
  def privacy; end
end


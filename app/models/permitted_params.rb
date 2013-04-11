class PermittedParams < Struct.new(:params, :current_user)

  # params for user
  def user
    params.require(:user).permit(*user_attributes)
  end

  # permitted attributes for user
  def user_attributes
    [:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :remember_me]
  end

end

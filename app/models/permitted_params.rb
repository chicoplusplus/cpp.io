# Helper class to use strong_parameters
class PermittedParams < Struct.new(:params, :current_user)

  # params for user
  def user
    params.require(:user).permit(*user_attributes)
  end

  # permitted attributes for user
  def user_attributes
    [:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :remember_me, :avatar, :avatar_cache, :remove_avatar, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h]
  end
  
  # params for topic
  def topic
    params.require(:topic).permit(*topic_attributes)
  end

  # permitted attributes for topic
  def topic_attributes
    [:name, :description]
  end

end

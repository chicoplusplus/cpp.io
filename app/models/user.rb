class User < ActiveRecord::Base
  # role_model implementation
  include RoleModel
  roles :admin

  # Devise authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
         :trackable, :validatable, :confirmable, :lockable, :timeoutable

  # Validations
  # email, password handled by devise
  validates :first_name, :presence => true, :length => { :maximum => 50 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }

  # Avatar
  mount_uploader :avatar, ImageUploader

  # Crop functionality
  def crop_avatar?
    avatar_changed = changed.include?('avatar')
    crop_changed = ['avatar_crop_x', 'avatar_crop_y', 'avatar_crop_w', 'avatar_crop_h'].any? { |a| !send(a.to_sym).blank? && changed.include?(a) }
    crop_empty = ['avatar_crop_w', 'avatar_crop_h'].any? { |a| send(a.to_sym) == 0 }
    avatar.present? && !avatar_changed && crop_changed && !crop_empty
  end

  before_save :crop_avatar
  def crop_avatar
    avatar.recreate_versions! if crop_avatar?
  end

  # Virtual attributes
  def full_name
    "#{first_name} #{last_name}"
  end
end

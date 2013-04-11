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

  # Virtual attributes
  def full_name
    "#{first_name} #{last_name}"
  end
end

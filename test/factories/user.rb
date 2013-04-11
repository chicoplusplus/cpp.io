FactoryGirl.define do
  factory :user do
    email Forgery::Internet.email_address
    first_name Forgery::Name.first_name
    last_name Forgery::Name.last_name
    factory_password = Forgery::Basic.password
    password factory_password
    password_confirmation factory_password
  end

end
require 'test_helper'

describe User do
  it 'should be valid' do
    user = FactoryGirl.build(:user)
    user.valid?.must_equal true
  end

  it 'should know its full name' do
    user = FactoryGirl.build(:user, :first_name => 'Matt', :last_name => 'Olson')
    user.full_name.must_equal 'Matt Olson'
  end

  it 'should require first and last name' do
    user = FactoryGirl.build(:user, :first_name => nil)
    user.valid?.must_equal false
    user.first_name = 'Matt'
    user.last_name = nil
    user.valid?.must_equal false
  end
  
  it 'should require a valid email address' do
    user = FactoryGirl.build(:user, :email => 'xxx')
    user.valid?.must_equal false
  end

  it 'should not be an admin by default' do
    user = FactoryGirl.build(:user)
    user.is?(:admin).must_equal false
  end
end


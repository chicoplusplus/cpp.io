require 'test_helper'

describe 'Authentication integration' do
  it 'should redirect to login page when accessing admin tool as unauthenticated user' do
    visit admin_root_path
    current_path.must_equal new_user_session_path
    find('#flashes').has_content?('need to sign in').must_equal true
  end
end


require 'test_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    @user = FactoryGirl.create(:user)
    @user.avatar = fixture_file_upload(Rails.root.join('test', 'photos', 'test-612x612.jpg'), 'image/jpeg')
    @user.save!
  end
  
  after do
    @user.remove_avatar = true
    @user.save!
  end

  it 'should upload images' do
    @user.valid?.must_equal true
  end

  it 'should create a large thumbnail of the right size' do
    @user.avatar.large.must be_no_larger_than(500, 500)
  end
  
  it 'should create a medium thumbnail of the right size' do
    @user.avatar.medium.must be_no_larger_than(150, 150)
  end
  
  it 'should create a thumb thumbnail of the right size' do
    @user.avatar.thumb.must be_no_larger_than(75, 75)
  end
  
  it 'should create a tiny thumbnail of the right size' do
    @user.avatar.tiny.must be_no_larger_than(25, 25)
  end

  it 'should crop properly' do
    `cp #{@user.avatar.thumb.current_path} /tmp/old_thumb`
    @user.crop_x = @user.crop_y = 50
    @user.crop_w = @user.crop_h = 200
    @user.save!
    '/tmp/old_thumb'.wont be_identical_to(@user.avatar.thumb.current_path)
    `rm /tmp/old_thumb`
  end
end

CarrierWave.configure do |config|
  config.storage = Rails.env.test? ? :file : :fog
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => ENV['AWS_REGION']
  }
  config.fog_directory = ENV['S3_BUCKET']
  config.fog_public = true
  config.root = Rails.root.join('tmp')
  config.cache_dir = "uploads"
  config.enable_processing = !Rails.env.test?
  # config.asset_host = 'https://assets.myapp.com'
  # config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
end

# Use fog mock so we don't slow down tests with actual file upload
Fog.mock!

connection = ::Fog::Storage.new(
  :provider               => 'AWS',
  :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
  :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
  :region                 => ENV['AWS_REGION']
)

connection.directories.create(:key => ENV['S3_BUCKET'])

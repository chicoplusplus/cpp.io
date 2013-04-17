#!/usr/bin/env ruby
# Generated by appscrolls and executed during the installation process

require 'aws-sdk'
s3 = AWS::S3.new({
  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
  :s3_endpoint => ENV['S3_ENDPOINT']
})

['production', 'test', 'development'].each do |e|
  bucket_name = "cppio-website-#{e}"
  puts "Creating S3 bucket '#{bucket_name}'..."
  s3.buckets.create(bucket_name) unless s3.buckets[bucket_name].exists?
end

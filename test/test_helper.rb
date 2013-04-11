ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/matchers'
require 'minitest/metadata'
require 'active_support/testing/setup_and_teardown'

# Require ruby files in support dir
Dir[File.expand_path('test/support/*.rb')].each { |file| require file }

# Setup class for integration tests
class IntegrationTest < MiniTest::Spec
  include Devise::TestHelpers
  include Rails.application.routes.url_helpers
  include MiniTest::Metadata
  register_spec_type(/integration$/, self)
end

# Setup class for helper tests
class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
end

# Setup class for uploader tests
class UploaderTest < MiniTest::Spec
  include ActionDispatch::TestProcess
  register_spec_type(/Uploader$/, self)
end

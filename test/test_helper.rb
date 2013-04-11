ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara/rails'
require 'pry-rescue/minitest'
require 'minitest/matchers'
require 'minitest/metadata'
require 'active_support/testing/setup_and_teardown'

# Require ruby files in support dir
Dir[File.expand_path('test/support/*.rb')].each { |file| require file }

# Setup class for integration tests
class IntegrationTest < MiniTest::Spec

  before do
    if metadata[:js]
      Capybara.current_driver = :webkit
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  include Capybara::DSL
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

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation
class MiniTest::Spec
  before :each do
    DatabaseCleaner.clean
  end
end

# Make test output a little easier on the eyes
Turn.config.format = :outline

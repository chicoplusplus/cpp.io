Rails.application.config.generators do |g|
  g.orm :active_record
  g.template_engine :erb
  g.test_framework nil # Using minitest, but don't want generators
  g.fixture_replacement :factory_girl, :dir => 'test/factories'
  g.scaffold_controller "scaffold_controller"
  g.stylesheets false
  g.javascripts false
end

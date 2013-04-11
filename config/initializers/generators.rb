Rails.application.config.generators do |g|
  g.orm :active_record
  g.template_engine :erb
  g.test_framework nil # Using minitest, but don't want generators
  g.fixture_replacement nil
  g.scaffold_controller "scaffold_controller"
  g.stylesheets true
  g.javascripts true
end

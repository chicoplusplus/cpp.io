Rails.application.config.generators do |g|
  g.orm :active_record
  g.template_engine :erb
  g.test_framework :test_unit, :fixture => true
  g.fixture_replacement nil
  g.scaffold_controller "scaffold_controller"
  g.stylesheets true
  g.javascripts true
end

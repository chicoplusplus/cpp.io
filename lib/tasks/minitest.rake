require "rake/testtask"

namespace :test do
  [:all, :models, :helpers, :controllers, :uploaders, :integration].each do |test_type|
    Rake::TestTask.new(test_type => "db:test:prepare") do |t|
      t.libs << "test"
      t.pattern = "test/#{test_type == :all ? '**' : test_type.to_s}/*_test.rb"
    end
  end
end

task :default => 'test:all'



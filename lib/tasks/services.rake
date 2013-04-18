module ServiceHelper
  SERVICE_SPECS = [
    {:name => :postgres, :pidfile=>"/usr/local/var/postgres/postmaster.pid", :start=>"pg_ctl -D /usr/local/var/postgres start", :stop=>"pg_ctl -D /usr/local/var/postgres stop -m fast"},
    {:name => :unicorn, :pidfile=>"./tmp/pids/unicorn.pid", :start=>"bundle exec unicorn_rails --listen 5000 --daemonize ./config.ru", :stop=>"kill $(cat ./tmp/pids/unicorn.pid); rm ./tmp/pids/unicorn.pid"}
  ]

  def service_status(service, quiet=false)
    retval = :unknown
    pidfile = service[:pidfile]

    if File.exists?(pidfile)
      process_id = File.open(pidfile) {|f| f.readline}
      ps_output = `ps -p #{process_id} &> /dev/null`
      if $?.exitstatus == 0
        puts "#{service[:name]} running; pid = #{process_id}" unless quiet
        retval = :running
      else
        puts "#{service[:name]} not running; stale pid = #{process_id}" unless quiet
        retval = :not_running
      end
    else
      puts "#{service[:name]} not running" unless quiet
      retval = :not_running
    end

    retval
  end

  def service_start(service)
    return unless service_status(service, true) == :not_running
    system "source config/env-development.bash && #{service[:start]}"
    service_status(service)
  end

  def service_stop(service)
    return unless service_status(service, true) == :running
    system "source config/env-development.bash && #{service[:stop]}"
    service_status(service)
  end
end

include ServiceHelper

namespace :services do
  desc "Get status of all services"
  task :status do
    SERVICE_SPECS.each { |s| service_status(s) }
  end

  desc "Start all services"
  task :start do
    SERVICE_SPECS.each { |s| service_start(s) }
  end

  desc "Stop all services"
  task :stop do
    SERVICE_SPECS.reverse_each { |s| service_stop(s) }
  end

  desc "Restart all services"
  task :restart do
    SERVICE_SPECS.reverse_each { |s| service_stop(s) }
    SERVICE_SPECS.each { |s| service_start(s) }
  end

  SERVICE_SPECS.each do |s|
    namespace s[:name] do
      desc "Get status of #{s[:name]} service"
      task :status do
        service_status(s)
      end

      desc "Start #{s[:name]}"
      task :start do
        service_start(s)
      end

      desc "Stop #{s[:name]}"
      task :stop do
        service_stop(s)
      end

      desc "Restart #{s[:name]}"
      task :restart do
        service_stop(s)
        service_start(s)
      end
    end
  end
end


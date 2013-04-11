module ServiceHelper
  SERVICE_SPECS = {
  :postgres => {:pidfile=>"/usr/local/var/postgres/postmaster.pid", :start=>"pg_ctl -D /usr/local/var/postgres start", :stop=>"pg_ctl -D /usr/local/var/postgres stop -m fast"},
  }

  def service_status(service_name, quiet=false)
    retval = :unknown
    pidfile = SERVICE_SPECS[service_name][:pidfile]

    if File.exists?(pidfile)
      process_id = File.open(pidfile) {|f| f.readline}
      ps_output = `ps -p #{process_id} &> /dev/null`
      if $?.exitstatus == 0
        puts "#{service_name} running; pid = #{process_id}" unless quiet
        retval = :running
      else
        puts "not running; stale pid = #{process_id}" unless quiet
        retval = :not_running
      end
    else
      puts "not running" unless quiet
      retval = :not_running
    end

    retval
  end
end

include ServiceHelper

namespace :services do
  SERVICE_SPECS.keys.each do |s|
    namespace s do
      desc "Get status of #{s} service"
      task :status do
        service_status s
      end

      desc "Start #{s}"
      task :start do
        next unless service_status(s, true) == :not_running
        system "source config/env-development.bash && #{SERVICE_SPECS[s][:start]}"
        service_status(s)
      end

      desc "Stop #{s}"
      task :stop do
        next unless service_status(s, true) == :running
        system "source config/env-development.bash && #{SERVICE_SPECS[s][:stop]}"
        service_status(s)
      end

      desc "Restart #{s}"
      task :restart do
        system "source config/env-development.bash && #{SERVICE_SPECS[s][:stop]} && #{SERVICE_SPECS[s][:start]}"
        service_status(s)
      end
    end
  end
end


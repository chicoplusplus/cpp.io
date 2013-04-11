worker_processes 4 # number of unicorn workers to spin up
timeout 30         # restarts workers that hang after <timeout> seconds
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection_handler.clear_all_connections!
end

after_fork do |server, worker|
  ActiveRecord::Base.connection_handler.verify_active_connections!
end

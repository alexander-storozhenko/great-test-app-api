threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

workers 2

port        ENV.fetch("PORT") { 3000 }

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
p "unix://#{shared_dir}/sockets/puma.sock"
bind "unix://#{shared_dir}/sockets/puma.sock"

pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")['development'])
end
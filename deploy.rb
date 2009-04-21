set :user, 'root'
role :target, ENV['CHEF_HOST']
set :run_method, :run

require 'rb-gems'

package :chef_client do
  gem 'chef' do
    post :install, 'mkdir -p /etc/chef'
    post :install, %(cat > /etc/chef/solo.rb <<EOF
log_level          :info
log_location       STDOUT
file_cache_path    "/tmp/chef-solo"
cookbook_path      "/tmp/chef-solo/cookbooks"
Chef::Log::Formatter.show_time = false
EOF)
  end
  requires :ohai
  requires :rubygems
  requires :ruby_dev
end

package :ohai do
  gem :ohai
end
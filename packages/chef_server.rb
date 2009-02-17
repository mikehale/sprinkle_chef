require 'chef_client'

package :chef_server do
  gem 'chef-server' do
    post :install, 'mkdir -p /etc/chef'
    post :install, %(cat > /etc/chef/solo.rb <<EOF
log_level          :info
log_location       STDOUT
file_cache_path    "/tmp/chef-solo"
cookbook_path      "/tmp/chef-solo/cookbooks"
Chef::Log::Formatter.show_time = false
EOF)
    post :install, 'chef-solo -r http://wiki.opscode.com/download/attachments/1179839/chef-server-install-solo-0.5.2.tar.gz'
  end
  requires :chef_client
  requires :rake
end

package :rake do
  gem 'rake'
end

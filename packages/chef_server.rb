require 'chef_client'

package :chef_server do
  gem 'chef-server' do
    post :install, 'mkdir -p /etc/chef'
    post :install, %(cat > ~/solo.rb <<EOF
file_cache_path    "/tmp/chef-solo"
cookbook_path      "/tmp/chef-solo/cookbooks"
EOF)
    2.times{
      post :install, 'sudo chef-solo -c ~/solo.rb -r http://s3.amazonaws.com/chef-solo/bootstrap-0.5.6.tar.gz'
    }
    post :install 'rm ~/solo.rb'
  end
  requires :chef_client
  requires :rake
end

package :rake do
  gem 'rake'
end

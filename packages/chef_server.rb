require 'chef_client'

package :chef_server do
  gem 'chef-server' do
    commands = []
    commands << 'mkdir -p /etc/chef'
    commands << 'mkdir -p /etc/chef'
    commands << %(cat > ~/solo.rb <<EOF
    file_cache_path    "/tmp/chef-solo"
    cookbook_path      "/tmp/chef-solo/cookbooks"
    EOF)
    2.times {
      commands << 'sudo chef-solo -c ~/solo.rb -r http://s3.amazonaws.com/chef-solo/bootstrap-0.5.6.tar.gz'
    }
    commands << 'rm ~/solo.rb'
    post :install, commands.join(' && ')
  end
  requires :chef_client
  requires :rake
end

package :rake do
  gem 'rake'
end

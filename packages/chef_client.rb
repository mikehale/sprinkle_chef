package :chef_client do
  gem 'chef' do
    post :install, 'mkdir -p /etc/chef'
    post :install, %(echo 'log_level :info\\nlog_location STDOUT\\nfile_cache_path "/tmp/chef-solo"\\ncookbook_path "/tmp/chef-solo/cookbooks"\\nChef::Log::Formatter.show_time = false' > /etc/chef/solo.rb)
  end
  requires :ohai
  requires :rubygems
  requires :ruby_dev
end

package :ohai do
  gem :ohai
end
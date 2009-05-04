package :chef_client do
  gem 'chef' do
    post :install, create_or_replace_file('~/solo.rb',
      ['file_cache_path "/tmp/chef-solo"',
       'cookbook_path "/tmp/chef-solo/cookbooks"'])
    post :install, create_or_replace_file('~/client.json', ['{ "recipes": "chef::client" }'])
    2.times {
      post :install, 'chef-solo -c ~/solo.rb -j ~/client.json -r http://s3.amazonaws.com/chef-solo/bootstrap-latest.tar.gz'
    }
  end
  requires :rubygems
  requires :ohai
end

package :ohai do
  gem :ohai
end
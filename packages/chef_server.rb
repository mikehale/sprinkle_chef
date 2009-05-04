package :chef_server do
  gem 'chef-server' do
    post :install, create_or_replace_file('~/solo.rb',
      ['file_cache_path "/tmp/chef-solo"',
       'cookbook_path "/tmp/chef-solo/cookbooks"'])
    post :install, create_or_replace_file('~/server.json', ['{ "recipes": "chef::server" }'])
    2.times {
      post :install, 'chef-solo -c ~/solo.rb -j server.json -r http://s3.amazonaws.com/chef-solo/bootstrap-latest.tar.gz'
    }
  end
  requires :rake
end

package :rake do
  gem 'rake'
end

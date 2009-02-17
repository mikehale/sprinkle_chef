require 'rb-gems'

package :chef_client do
  gem 'chef' do
    pre :install, 'gem sources|grep opscode || gem sources -a http://gems.opscode.com'
  end
  requires :ohai
  requires :rubygems
  requires :ruby_dev
end

package :ohai do
  gem :ohai
end
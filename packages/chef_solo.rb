package :chef_solo do
  gem 'chef'
  requires :rubygems
  requires :ohai
end

package :ohai do
  gem :ohai
end
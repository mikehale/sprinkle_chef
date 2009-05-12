package :chef_solo do
  gem 'chef'
  requires :rubygems
  requires :ohai
  requires :rsync
end

package :ohai do
  gem :ohai
end

package :rsync do
  apt 'rsync'
end
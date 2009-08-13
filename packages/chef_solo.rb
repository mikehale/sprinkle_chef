package :chef_solo do
  gem 'chef'
  requires :rubygems
  requires :ohai
  requires :rsync
  requires :wget
  requires :ssl_cert
end

package :wget do
  apt "wget"
end

package :ssl_cert do
  apt "ssl-cert"
end

package :ohai do
  gem :ohai
end

package :rsync do
  apt 'rsync'
end
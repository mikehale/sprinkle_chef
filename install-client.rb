#!/usr/bin/env sprinkle -s

$LOAD_PATH << File.join(File.dirname(__FILE__), 'packages')

require 'chef_server'

policy :chef_client, :roles => :server do
  requires :chef_client
end

deployment do
  delivery :ssh do
    roles(:server => ENV['CHEF_HOST'])
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/src'
  end
end

#!/usr/bin/env sprinkle -s

$LOAD_PATH << File.dirname(__FILE__)

require 'build_essential'
require 'ruby_enterprise_edition'

policy :singleserver, :roles => :app do
  requires :ruby1_8_6
end

deployment do
  delivery :capistrano do
    recipes 'deploy'
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
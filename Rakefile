require 'sprinkle'

task :host do
  HOST = ENV['HOST'] if ENV['HOST']
  raise "Must provide a HOST=" unless self.class.const_defined?('HOST')
end

desc "Add your public ssh key to the server to support passwordless logins (with HOST=your-server)"
task :add_ssh_key => :host do
  puts "Enter the path to your ssh public key [~/.ssh/id_rsa.pub]:"
  input = $stdin.gets.chomp
  public_key_path = input.empty? ? "~/.ssh/id_rsa.pub" : input
  public_key = `cat #{public_key_path}`.chomp

  cmds = ["mkdir -p /root/.ssh/ -m 0600"]
  cmds << "echo \'#{public_key}\' > /root/.ssh/authorized_keys"
  puts cmds = "'#{cmds.join(' && ')}'"
  print `ssh root@#{HOST} #{cmds}`
end

namespace :chef do
  %w(client server solo).each do |e|
    desc "Build a chef-#{e} from scratch (with HOST=your-server)"
    task(e.to_sym => :host) { install(e) }
  end

  def install(what)
    # Sprinkle::OPTIONS[:force] = true
    Sprinkle::OPTIONS[:verbose] = true
    # Sprinkle::OPTIONS[:test] = true
    $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
    Sprinkle::Script.sprinkle script(what, HOST)
  end

  def script(what, host)
    %(require 'packages/base'
require 'packages/build_essential'
require 'packages/ruby'
require 'packages/rubygems'
require 'packages/chef_server'
require 'packages/chef_client'
require 'packages/chef_solo'

policy :chef_#{what}, :roles => :#{what} do
  requires :chef_#{what}
end

deployment do
  delivery :capistrano do
    set :user, 'root'
    role :#{what}, '#{host}'
    set :run_method, :run

    debug = true if ENV['DEBUG'] == 'true'
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/src'
    builds   '/usr/local/src'
  end
end
    )
  end
end

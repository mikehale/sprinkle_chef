require 'sprinkle'

desc "Add your public ssh key to the server to support passwordless logins."
task :add_ssh_key do
  raise "Must provide a CHEF_HOST=" unless ENV["CHEF_HOST"]
  puts "Enter the path to your ssh public key [~/.ssh/id_rsa.pub]:"
  input = $stdin.gets.chomp
  public_key_path = input.empty? ? "~/.ssh/id_rsa.pub" : input
  public_key = `cat #{public_key_path}`.chomp

  cmds = ["mkdir -p /root/.ssh/ -m 0600"]
  cmds << "echo \'#{public_key}\' > /root/.ssh/authorized_keys"
  puts cmds = "'#{cmds.join(' && ')}'"
  print `ssh root@#{ENV["CHEF_HOST"]} #{cmds}`
end

namespace :chef do
  %w(client server).each do |e|
    desc "Build a chef-#{e} from scratch (with CHEF_HOST=your-server)"
    task(e.to_sym) { install(e) }
  end

  def install(what)
    raise "Must provide a CHEF_HOST=" unless ENV["CHEF_HOST"]
    # Sprinkle::OPTIONS[:force] = true
    # Sprinkle::OPTIONS[:test] = true
    Sprinkle::Script.sprinkle script(what, ENV["CHEF_HOST"])
  end
  
  def script(what, host)
    %(
$LOAD_PATH << File.join(File.dirname(__FILE__), 'packages')

require 'chef_#{what}'

policy :chef_#{what}, :roles => :server do
  requires :chef_#{what}
end

deployment do
  delivery :ssh do
    roles(:server => '#{host}')
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


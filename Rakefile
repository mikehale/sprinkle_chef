require 'sprinkle'

namespace :chef do
  %w(client server).each do |e|
    desc "Build a chef-#{e} from scratch (with CHEF_HOST=your-server)"
    task e.to_sym do
      install(e)
    end
  end

  def install(what)
    raise "Must provide a CHEF_HOST=" unless ENV["CHEF_HOST"]
    # Sprinkle::OPTIONS[:force] = true
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


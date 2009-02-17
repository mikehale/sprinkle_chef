require 'sprinkle'

namespace :chef do
  %w(client server).each do |e|
    desc "Build a #{e}-client from scratch"
    task e.to_sym do
      install(e)
    end
  end

  def install(what)
    raise "Must provide a CHEF_HOST=" unless ENV["CHEF_HOST"]
    powder = "install-#{what}.rb"
    Sprinkle::Script.sprinkle File.read(powder), powder
  end
end


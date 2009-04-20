package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    pre :install, 'apt-get update'
  end

  verify do
    has_executable 'gcc'
  end
end
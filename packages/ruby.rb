package :ruby do
  apt "ruby ruby1.8-dev libopenssl-ruby1.8 rdoc ri irb"
  requires :zlib_dev
  requires :libssl_dev
  requires :libreadline_dev
end
package(:zlib_dev) { apt "zlib1g-dev" }
package(:libssl_dev) { apt "libssl-dev" }
package(:libreadline_dev) { apt "libreadline5-dev" }

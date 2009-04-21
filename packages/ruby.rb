package :ruby do
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.6.tar.bz2"
  
  requires :zlib_dev
end

package(:zlib_dev) { apt "zlib1g-dev" }

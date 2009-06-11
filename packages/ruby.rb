package :ruby do
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.6-p369.tar.bz2"
  custom_install "./configure --prefix=/usr/local --with-openssl-dir=/usr --with-readline-dir=/usr --with-zlib-dir=/usr && make && make install"
  requires :zlib_dev
  requires :libssl_dev
  requires :libreadline_dev
end
package(:zlib_dev) { apt "zlib1g-dev" }
package(:libssl_dev) { apt "libssl-dev" }
package(:libreadline_dev) { apt "libreadline5-dev" }

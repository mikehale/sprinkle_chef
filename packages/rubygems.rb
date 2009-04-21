package :rubygems do
  description 'Ruby Gems'
  version '1.3.2'
  source "http://rubyforge.org/frs/download.php/55066/rubygems-1.3.2.tgz" do
    pre :install, 'echo "gem: --no-rdoc --no-ri" >> /etc/gemrc;'
    custom_install 'ruby setup.rb'
    # post :install, 'ln -nfs /usr/bin/gem1.8 /usr/bin/gem'
    post :install, 'gem sources -a http://gems.opscode.com'
    post :install, 'gem update'
    post :install, "gem update --system"
  end

  requires :ruby
  requires :zlibc
end

package(:zlibc) { apt "zlibc" }

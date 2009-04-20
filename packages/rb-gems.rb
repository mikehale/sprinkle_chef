require 'build_essential'
require 'ruby'

module RubyGemsVerifier
  def has_rubygems(version)
    @commands << "which gem > /dev/null && [ '#{version}' == `gem --version` ]"
  end
end
Sprinkle::Verify.register(RubyGemsVerifier)

package :rubygems do
  description 'Ruby Gems'
  version '1.3.1'
  source "http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz" do
    pre :install, 'echo "gem: --no-rdoc --no-ri" >> /etc/gemrc;'
    custom_install 'ruby setup.rb'
    post :install, 'ln -nfs /usr/bin/gem1.8 /usr/bin/gem'
    post :install, 'gem sources -a http://gems.opscode.com'
    post :install, 'gem update'
    post :install, "gem update --system"
  end

  verify 'binary' do
    has_file '/usr/bin/gem'
    has_symlink '/usr/bin/gem'
  end

  verify 'version' do
    has_rubygems(version)
  end

  requires :ruby_dev
end
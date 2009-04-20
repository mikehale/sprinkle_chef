package :ruby do
  apt %w(ruby1.8)
end

package :ruby_dev do
  apt %w(ruby1.8-dev libopenssl-ruby1.8 rdoc1.8)
  requires :ruby
end

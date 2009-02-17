package :ruby do
  apt %w(ruby)
end

package :ruby_dev do
  apt %w(ruby1.8-dev libopenssl-ruby1.8)
end

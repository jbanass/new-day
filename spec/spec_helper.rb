require 'bundler'
require 'pry'

$:.unshift File.expand_path('../lib', __FILE__)

RSpec.configure do |c|
  c.tty = true
end

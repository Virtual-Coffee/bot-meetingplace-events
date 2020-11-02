require 'rubygems'
Bundler.require :default, (ENV['RACK_ENV'] || 'development').to_sym

require 'bundler'
Bundler.setup
require 'zeitwerk'
require 'active_support/core_ext'

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.setup

module VirtualCoffeeBot
end

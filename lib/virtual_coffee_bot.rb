require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || 'development').to_sym
Bundler.setup

require 'zeitwerk'
require 'active_support/core_ext'

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.setup

module VirtualCoffeeBot
end

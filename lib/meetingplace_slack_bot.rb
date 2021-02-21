require "rubygems"
require "bundler"
require "bundler/setup"

require "active_support"
require "active_support/core_ext/time"
require "zeitwerk"

require "slack-ruby-bot"

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.setup

module MeetingplaceSlackBot
end

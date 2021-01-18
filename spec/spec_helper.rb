$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".."))

ENV["RACK_ENV"] ||= "test"
ENV["SLACK_API_TOKEN"] ||= "sample_slack_api_token"

require "simplecov"
SimpleCov.start

require "lib/virtual_coffee_bot"

require "slack-ruby-bot/rspec"
require "webmock/rspec"
require "timecop"

# WebMock.allow_net_connect!
WebMock.disable_net_connect!(allow_localhost: true)

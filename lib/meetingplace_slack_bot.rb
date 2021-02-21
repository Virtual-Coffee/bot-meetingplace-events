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
  module Config
    def channel
      @channel ||= ENV["SLACK_CHANNEL"]
    end

    def group_id
      @group_id ||= ENV["MEETINGPLACE_GROUP"]
    end

    def slack_client
      @slack_client ||= Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
    end
  end
end

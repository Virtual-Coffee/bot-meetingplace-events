require "slack-ruby-bot"
require "dotiw"

# Describes the configuration
module MeetingplaceSlackBot
  module Reports
    class Info
      include DOTIW::Methods

      def call(slack_channel = nil, meetingplace_group = nil)
        @channel = slack_channel
        @group_url = meetingplace_group
        slack_client.chat_postMessage(channel: channel, blocks: blocks, as_user: true)
      end

      private

      def blocks
        [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": text
            }
          }
        ]
      end

      def text
        ["I am the Meetingplace Slack Bot!",
          "I'll tell send you messages when there are upcoming events with <https://meetingplace.io/#{group_url}|#{group_url}>."].join("\n\n")
      end

      def channel
        @channel ||= ENV["SLACK_CHANNEL"] ||= "#general"
      end

      def group_url
        @group_url ||= ENV["MEETINGPLACE_GROUP"] ||= "virtual-coffee"
      end

      def slack_client
        @slack_client ||= Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
      end
    end
  end
end

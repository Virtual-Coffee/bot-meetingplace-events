require "slack-ruby-bot"
require "dotiw"

# Describes the configuration
module MeetingplaceSlackBot
  module Reports
    class Info
      include DOTIW::Methods

      def call
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
        [ "I am the Meetingplace Slack Bot!  I'll tell send you messages when there are upcoming events with <https://meetingplace.io/#{group_url}|#{group_url}> like:",
          "📅 *Next Event:* Your event name",
          "Starting in 10 minutes! | <https://meetingplace.io/#{group_url}|View Details>",
        ].join("\n\n")
      end
    
      def channel
        ENV["SLACK_CHANNEL"] ||= "#events"
      end

      def group_url
        ENV["MEETINGPLACE_GROUP"] ||= "women-in-robotics"
      end

      def slack_client
        @slack_client ||= Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
      end
    end
  end
end

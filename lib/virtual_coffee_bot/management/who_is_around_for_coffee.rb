require "slack-ruby-bot"
require "dotiw"

# Creates a standup message to be run every Monday morning to report all the events for that week
module VirtualCoffeeBot
  module Management
    class WhoIsAroundForCoffee
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
        [
          "Who is around for the Tuesday Coffee?",
          "Reply with:",
          "⭐️ - You'd like to host",
          "🎤 - You're able to MC",
          "🦦 - You'd like to be a room leader",
          "📝 - You're able to take notes"
        ].join("\n")
      end

      def channel
        "#general"
      end

      def slack_client
        @slack_client ||= Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
      end
    end
  end
end

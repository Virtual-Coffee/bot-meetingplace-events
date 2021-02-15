require "slack-ruby-bot"
require "dotiw"

# Creates a standup message to be run every Monday morning to report all the events for that week
module VirtualCoffeeBot
  module Management
    class WhoIsAroundForCoffee
      include DOTIW::Methods

      def call
        puts slack_client.chat_postMessage(channel: channel, blocks: blocks, as_user: true).inspect
      end

      def get_users_doing_stuff
        puts slack_client.conversations_history(channel: '#general', sort: 'timestamp').messages.first.bot_profile.name.inspect
        puts slack_client.conversations_history(channel: '#general', sort: 'timestamp').messages.first.reactions.inspect

        puts slack_client.chat_postMessage(channel: channel, blocks: response_blocks, as_user: true).inspect
      end

      private

      def response_blocks
        [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": response_text
            }
          }
        ]
      end

      def response_text
        [
          "*Tuesday:*",
          "Who's going to be there and is up for room lead or note-taking?",
          "*MC:* <@UK3G0UE8K>",
          "*Host:* <@UK3G0UE8K>",
          "*Room Leader* ------ *Notetaker*",
          "<@UK3G0UE8K> ----- <@UK3G0UE8K>",
          "*Ice-breaker:* What is your favourite binary",
          "Backpocket topic: "
        ].join("\n")
      end

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

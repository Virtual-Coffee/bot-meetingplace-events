require "slack-ruby-bot"
require "dotiw"

# Describes the configuration
module MeetingplaceSlackBot
  module Reports
    class GroupInfo
      include DOTIW::Methods
      include MeetingplaceSlackBot::Config

      def call(slack_channel = nil, meetingplace_group = nil)
        @channel = slack_channel
        @group_id = meetingplace_group
        slack_client.chat_postMessage(channel: channel, attachments: attachments, as_user: true)
      end

      private

      def info
        @info ||= MeetingPlace::Info.new(group_id)
      end

      def attachments
        [
          {
            "color": "#2fa3c3",
            "blocks": [
              {
                "type": "section",
                "text": {
                  "type": "mrkdwn",
                  "text": "*<#{info.url}|#{info.name}>*\n\n#{info.short_description}"
                },
                "accessory": {
                  "type": "image",
                  "image_url": info.image.to_s,
                  "alt_text": info.name.to_s
                }
              }
            ]
          }
        ]
      end
    end
  end
end

require "slack-ruby-bot"
require "dotiw"

# Creates a standup message to be run every Monday morning to report all the events for that week
module MeetingplaceSlackBot
  module Reports
    class ThisWeeksEvents
      include DOTIW::Methods
      include MeetingplaceSlackBot::Config

      def call(slack_channel = nil, meetingplace_group = nil)
        @channel = slack_channel
        @group_id = meetingplace_group
        return unless upcoming_events.any?

        slack_client.chat_postMessage(channel: channel, blocks: blocks, as_user: true)
      end

      private

      def blocks
        [
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: text
            }
          }
        ]
      end

      def text
        [
          "📆 *This Weeks Events Are:*",
          upcoming_as_text
        ].join("\n\n")
      end

      def upcoming_as_text
        upcoming_events.collect { |event|
          "• #{event.name} | #{event.slack_markdown_start_time}"
        }.join("\n")
      end

      def upcoming_events
        @upcoming_events ||= all_events
          .select { |event| date_range.cover?(event.start_time) }
      end

      def date_range
        (Time.now.utc.beginning_of_week..(Time.now.utc.end_of_week))
      end

      def all_events
        @all_events ||= MeetingPlace::Events.new(group_id).call
      end
    end
  end
end

require 'slack-ruby-bot'

# Ran every hour. Add a 10 minute warning that an event is about to start.
module VirtualCoffeeBot
  module Reports
    class NextEvent
      def call
        return unless next_event.present?

        slack_client.chat_postMessage(channel: channel, text: text, as_user: true)
      end

      private

      def text
        [
          "📅 *Next Event:* #{next_event.name}",
          "Starting in #{next_event.time_to_start} | <#{next_event.url}|View Details>"
        ].join("\n\n")
      end

      def next_event
        @next_event ||= all_events
                        .select { |event| event.starts_during_the_hour?(start_time_to_an_hours_precision) }
                        .first
      end

      def start_time_to_an_hours_precision
        @start_time_to_an_hours_precision ||= Time.now.utc.beginning_of_hour + 1.hour
      end

      def all_events
        @all_events ||= MeetingPlace::Events.new('virtual-coffee').call
      end

      def channel
        ENV['SLACK_CHANNEL'] ||= '#general'
      end

      def slack_client
        @slack_client ||= Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN'])
      end
    end
  end
end

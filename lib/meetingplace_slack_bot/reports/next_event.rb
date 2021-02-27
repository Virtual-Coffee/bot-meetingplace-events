require "slack-ruby-bot"

# Ran every hour. Add a 10 minute warning that an event is about to start.
module MeetingplaceSlackBot
  module Reports
    class NextEvent < ThisWeeksEvents
      private

      def text
        [
          "📅 Next event is starting in #{next_event.time_to_start}!",
          "*#{next_event.name}*",
          next_event.slack_description,
          "<#{next_event.url}|View Details>"
        ].join("\n\n")
      end

      def next_event
        upcoming_events.first
      end

      def upcoming_events
        @next_event ||= all_events
          .select { |event| event.starts_during_the_hour?(start_time_to_an_hours_precision) }
      end

      def start_time_to_an_hours_precision
        @start_time_to_an_hours_precision ||= Time.now.utc.beginning_of_hour + 1.hour
      end
    end
  end
end

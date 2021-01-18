# Creates a message summarising the
module VirtualCoffeeBot
  module Reports
    class TodaysEvents < ThisWeeksEvents
      private

      def text
        [
          "📆 *Todays Events Are:*",
          upcoming_as_text
        ].join("\n\n")
      end

      def upcoming_events
        @upcoming_events ||= all_events
          .select { |event| date_range.cover?(event.start_time) }
      end

      def date_range
        (Time.now.utc.beginning_of_day..(Time.now.utc.end_of_day))
      end
    end
  end
end

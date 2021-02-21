require "dotiw"

# Represents an event on MeetingPlace
# Has common methods I wanted to format
module MeetingPlace
  class Event
    include DOTIW::Methods

    def initialize(data)
      @data = data
    end

    def name
      @data["name"]
    end

    def url
      @data["url"]
    end

    def description
      @data["description"]
    end

    def location
      @data["location"]
    end

    def start_time
      @start_time ||= Time.parse(@data["start_time"])
    end

    def slack_markdown_start_time
      fallback_text = start_time.strftime("%A #{start_time.day.ordinalize} @ %H:%M %p (%z)")

      "<!date^#{start_time.to_i}^{date_long_pretty} @ {time}^#{url}|#{fallback_text}>"
    end

    def time_to_start
      distance_of_time_in_words(Time.now.utc, start_time)
    end

    def starts_during_the_hour?(hour)
      start_time.beginning_of_hour == hour
    end
  end
end

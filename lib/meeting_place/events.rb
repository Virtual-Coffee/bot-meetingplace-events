# Used to pull all the events from MeetingPlace.
module MeetingPlace
  class Events
    def initialize(group)
      @group = group
    end

    def call
      data.collect do |event|
        MeetingPlace::Event.new(event)
      end
    end

    private

    def data
      @data ||= begin
        uri = URI(endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri)
        response = http.request(request)
        JSON.parse(response.body)
      end
    end

    def endpoint
      "https://meetingplace.io/api/v1/group/#{@group}/events.json"
    end
  end
end

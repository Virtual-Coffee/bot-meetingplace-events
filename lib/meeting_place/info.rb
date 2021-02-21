# Used to pull group info from MeetingPlace.
require "net/http"

module MeetingPlace
  class Info
    def initialize(group)
      @group = group
    end

    def name
      data["name"]
    end

    def url
      data["url"]
    end

    def short_description
      data["short_description"]
    end

    def description
      data["description"]
    end

    def location
      data["location"]
    end

    def timezone
      data["timezone"]
    end

    def image
      data["image"]
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
      "https://meetingplace.io/api/v1/group/#{@group}.json"
    end
  end
end

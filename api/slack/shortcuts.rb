require "json"

Handler = Proc.new do |request, response|
  if request["content-type"] == "application/x-www-form-urlencoded"
    payload = Hash[URI.decode_www_form(request.body)]["payload"]

    response.status = 200
    response.body = {
      blocks: [
        {
          type: "section",
          text: {
            type: "mrkdwn", text: "Callback is: #{payload["callback_id"]}"
          }
        },
      ]
    }.to_json
  else
    response.status = 401
    response.body = "Request not valid"
  end
end

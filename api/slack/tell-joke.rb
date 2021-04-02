require "json"

Handler = proc do |request, response|
  if request["content-type"] == "application/x-www-form-urlencoded"
    command = Hash[URI.decode_www_form(request.body)]["command"]

    response.status = 200
    response["Content-Type"] = "application/json; charset=utf-8"

    response.body = {
      blocks: [
        {
          type: "section",
          text: {
            type: "mrkdwn", text: "Command was: #{command}"
          }
        }
      ]
    }.to_json
  else
    response.status = 401
    response.body = "Request not valid"
  end
end

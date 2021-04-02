require "json"
require "slack-ruby-bot"

Handler = proc do |request, response|
  if request.query['auth_token'] == "HelloWorld"
    channel = request.query['channel'] || ENV["SLACK_CHANNEL"]

    # Post a message
    slack_client ||= Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
    slack_client.chat_postMessage(channel: channel, text: "Hello from Vercel", as_user: true)

    response.status = 200
    response["Content-Type"] = "application/json; charset=utf-8"
    response.body = {successful: "GO check slack, I just said hi!"}.to_json
  else
    response.status = 401
    response.body = "Request not valid"
  end
end

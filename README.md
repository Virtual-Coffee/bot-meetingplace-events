# Meetingplace Slack Bot

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This friendly bot reports when the next event is.

It pulls the data from the [Meeting Place API](https://meetingplace.io/api).

## Sample Output

![image](https://user-images.githubusercontent.com/325384/97884868-81de8380-1d1e-11eb-9a6f-0a6f9f2d1b7e.png)

```
📅 *Next Event:* Virtual Coffee - Morning Crowd
Starting in 10 minutes! <https://meetingplace.io/virtual-coffee/events/3185|View Details>
```

## Setting up

The bot runs on heroku.

Start the development environment in vscode

Follow the [tutorial](https://blog.heroku.com/how-to-deploy-your-slack-bots-to-heroku) on deploying a slack bot to heroku.

This uses a ruby config.

### Set up heroku

Log into heroku

```
heroku login
```

Create the app

```
heroku create meetingplace-slack-bot
```

Push the code 

```
git push heroku main
```

Open the app in a browser

```
heroku open
```

See the logs 

```
heroku logs --tail
```

> :pencil: Note this results in an `bundler: command not found: rackup` error

### Set up slack

First, visit slack.com/apps/build and select "Make a Custom Integration".

Set up an "Incoming WebHook" on Slack and connect it to a channel.

> :pencil: It might be a good idea to set up a testing channel just for this integration

Grab the _"webhook url"_.  It should look something like this: https://hooks.slack.com/services/T0..LN/B0..VV1/br..dd

### Set up the heroku configuration

The following secrets should be set in the heroku config

heroku config:set WEBHOOK_URL=https://hooks.slack.com/services/T0..LN/B0..VV1/br..dd

It requires the following:

| Secret               | Source                                                     | Purpose                                              |
| -------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| `SLACK_API_TOKEN`    | [Bot User OAuth Access Token](https://api.slack.com/apps/) | This allows us to post as a bot to slack             |
| `SLACK_CHANNEL`      |                                                            | This allows the bot to chat in the specified channel |
| `MEETINGPLACE_GROUP` | [Meetingplace group url](https//meetingplace.io/api)       | This tells the bot what group to post events from    |

### Slack Bot Token Scopes

The following scopes need to be added to your Slack Bot to allow it to post messages.

| Scope               |
| ------------------- |
| `chat:write.public` |
| `channels:read`     |
| `chat:write`        |

## Scheduled Messages

Currently there are three scheduled tasks which run:

| Rake Task                              | When it should be run                | Purpose                                               | Crontab      |
| -------------------------------------- | ------------------------------------ | ----------------------------------------------------- | ------------ |
| `virtual_coffee_bot:next_event`        | Hourly ~15 minutes before the hour   | Gives a heads up that a new meeting is about to start | `45 * * * *` |
| `virtual_coffee_bot:todays_events`     | Every morning at 8am (Except Monday) | Tells us in the morning an event will happen that day | `0 8 * * *`  |
| `virtual_coffee_bot:this_weeks_events` | Every Monday at 8am UTC              | Lists all the meetings starting that week             | `0 8 * * *`  |

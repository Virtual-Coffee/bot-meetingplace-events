# Meetingplace Slack Bot

This friendly bot sends a slack message for upcoming events. It pulls the data from the [Meeting Place API](https://meetingplace.io/api).

## Sample Output

![image](https://user-images.githubusercontent.com/325384/97884868-81de8380-1d1e-11eb-9a6f-0a6f9f2d1b7e.png)

```
📅 *Next Event:* Virtual Coffee - Morning Crowd
Starting in 10 minutes! <https://meetingplace.io/virtual-coffee/events/3185|View Details>
```

## Setting up

### Quickstart

The bot runs on heroku.  The easiest way to deploy is to click on the button below to create the heroku app, set up your [slack integration](#set-up-slack), and then follow the directions to send [scheduled messages](#scheduled-messages)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### Manual setup
Start the development environment in vscode

Follow the [tutorial](https://blog.heroku.com/how-to-deploy-your-slack-bots-to-heroku) on deploying a slack bot to heroku.

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
> :pencil: This results in an `bundler: command not found: rackup` error.  We will not be running rackup, instead we will be setting up scheduler to run rake tasks.

See the logs 

```
heroku logs --tail
```

### Set up slack

First, visit https://slack.com/apps/build and select "Create a custom app".

Click on "permissions" -> "Add OAuth Scopes"

The following scopes need to be added to your Slack Bot to allow it to post messages.

| Scope               |
| ------------------- |
| `chat:write.public` |
| `chat:write`        |
| `channels:read`     |


> :pencil: It might be a good idea to set up a testing channel for this integration

### Environment configuration

The following secrets should be set in environment variables

| Secret               | Source                                                     | Purpose                                              |
| -------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| `SLACK_API_TOKEN`    | [Bot User OAuth Access Token](https://api.slack.com/apps/) | This allows us to post as a bot to slack             |
| `SLACK_CHANNEL`      |                                                            | This allows the bot to chat in the specified channel |
| `MEETINGPLACE_GROUP` | [Meetingplace group url](https//meetingplace.io/api)       | This tells the bot what group to post events from    |


You can set these in heroku from the command line with:

```
heroku config:set SECRET=value
```

### Run locally

To run locally, create a `.env` file in the root of this directory with the environment keys listed in [environment configuration](#environment-configuration)

Then you can run the rake tasks


```bash
bundle exec rake meetingplace_slack_bot:info
bundle exec rake meetingplace_slack_bot:next_event
bundle exec rake meetingplace_slack_bot:todays_events
bundle exec rake meetingplace_slack_bot:this_weeks_events
```

### Run on heroku

```bash
heroku run rake meetingplace_slack_bot:info
heroku run rake meetingplace_slack_bot:next_event
heroku run rake meetingplace_slack_bot:todays_events
heroku run rake meetingplace_slack_bot:this_weeks_events
```

## Scheduled Messages

Set up heroku scheduler.

> :pencil: You will need to provide your credit card info to set up the scheduler, but the usage should remain within the free limits.

Currently there are three scheduled tasks which run:

| Rake Task                                  | When it should be run                    | Purpose                                               |
| ------------------------------------------ | ---------------------------------------- | ----------------------------------------------------- |
| `meetingplace_slack_bot:next_event`        | Hourly ~10 minutes before the hour       | Gives a heads up that a new meeting is about to start |
| `meetingplace_slack_bot:todays_events`     | Every morning at 8am UTC (Except Monday) | Tells us in the morning an event will happen that day |
| `meetingplace_slack_bot:this_weeks_events` | Every Monday at 8am UTC                  | Lists all the meetings starting that week             |


If you deployed manually (not using the button) set up heroku with scheduler

```bash
heroku addons:create scheduler:standard
```

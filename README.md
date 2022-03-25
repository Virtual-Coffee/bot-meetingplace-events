# Meetingplace Slack Bot

This friendly bot sends a slack message for upcoming events. It pulls the data from the [Meeting Place API](https://meetingplace.io/api).

## Sample Output

![image](https://user-images.githubusercontent.com/325384/97884868-81de8380-1d1e-11eb-9a6f-0a6f9f2d1b7e.png)

```
📅 *Next Event:* Virtual Coffee - Morning Crowd
Starting in 10 minutes! <https://meetingplace.io/virtual-coffee/events/3185|View Details>
```

## Quickstart

The bot runs on heroku.  The easiest way to deploy is to click on the button below to create the heroku app, set up your [slack integration](#set-up-slack), and then follow the directions to send [scheduled messages](#scheduled-messages)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Manual setup
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

| Secret               | Source                                                     | Purpose                                                   |
| -------------------- | ---------------------------------------------------------- | --------------------------------------------------------- |
| `SLACK_API_TOKEN`    | [Bot User OAuth Access Token](https://api.slack.com/apps/) | This allows us to post as a bot to slack                  |
| `SLACK_CHANNEL`      |                                                            | This is the default channel for the bot                   |
| `MEETINGPLACE_GROUP` | [Meetingplace group url](https//meetingplace.io/api)       | This is the default group for the bot to post events from |


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

### Run options

Each task has optional settings [channel, group_id] to let you set tasks for different channels and groups.

example:

```bash
bundle exec rake meetingplace_slack_bot:info["test-channel","virtual-coffee"]
```

## Scheduled Messages

Set up heroku scheduler.

> :pencil: You will need to provide your credit card info to set up the scheduler, but the usage should remain within the free limits.

If you deployed manually (not using the button) set up heroku with scheduler

```bash
heroku addons:create scheduler:standard
```

To add a task to the scheduler, first open up the app within your heroku project

![scheduler-1](https://user-images.githubusercontent.com/6098197/108635650-4edb0f80-7435-11eb-9a2b-c0f002f99902.png)

Then select add job

![scheduler-2](https://user-images.githubusercontent.com/6098197/108635655-569ab400-7435-11eb-9b72-3ee03e6630c1.png)

Then setup the schedule for your task

![scheduler-3](https://user-images.githubusercontent.com/6098197/108635661-5f8b8580-7435-11eb-9552-3c08767afdf9.png)

Possible tasks:

```bash
rake meetingplace_slack_bot:event_report[channel,group,hour]  # Send event reminders for group
rake meetingplace_slack_bot:info[channel,group]               # Gets a description of the group
rake meetingplace_slack_bot:next_event[channel,group]         # Posts to Slack if an event is starting in the next 15 minutes
rake meetingplace_slack_bot:send_reports                      # Loop through all chapters in config file and send reports
rake meetingplace_slack_bot:this_weeks_events[channel,group]  # Posts to Slack the events for this week (Only runs on Monday)
rake meetingplace_slack_bot:todays_events[channel,group]      # Posts to Slack if an event occouring today (Does not run on Monday)
```

Currently there is one scheduled tasks which runs:

| Rake Task                                  | When it should be run              | Purpose                                                   |
| ------------------------------------------ | ---------------------------------- | --------------------------------------------------------- |
| `rake meetingplace_slack_bot:send_reports` | Hourly ~10 minutes before the hour | Loop through all chapters in config file and send reports |

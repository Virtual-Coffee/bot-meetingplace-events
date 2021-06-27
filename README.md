# Bot : MeetingPlace Events

This friendly bot reports when the next event is in our Slack.

It pulls the data from the [MeetingPlace API](https://meetingplace.io/api/v1/group/virtual-coffee/events.json).

## Sample Output

![Slack Message showing this weeks events](https://user-images.githubusercontent.com/325384/123550836-fbefcc80-d734-11eb-9519-ce0642abdd28.png)

![Daily Reminder & Pre Event reminder](https://user-images.githubusercontent.com/325384/123550882-204ba900-d735-11eb-824c-b431cddc9f4d.png)

```
📅 *Next Event:* Virtual Coffee - Morning Crowd
Starting in 10 minutes! <https://meetingplace.io/virtual-coffee/events/3185|View Details>
```

## Setting up

The bot runs on a schedule as managed by Heroku Scheduler (We did try GitHub Actions, but they proved unreliable at running on time). It requires the following [secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets) to be setup:

| Secret            | Source                                                      | Purpose                                   |
| ----------------- | ----------------------------------------------------------- | ----------------------------------------- |
| `SLACK_API_TOKEN` | [Bot User OAuth Access Token](https://api.slack.com/apps/)  | This allows us to post as a bot to slack  |

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
| -------------------------------------- | ------------------------------------ | ----------------------------------------------------- | -------------|
| `virtual_coffee_bot:next_event`        | Hourly ~15 minutes before the hour   | Gives a heads up that a new meeting is about to start | `45 * * * *` |
| `virtual_coffee_bot:todays_events`     | Every morning at 8am (Except Monday) | Tells us in the morning an event will happen that day | `0 8 * * *`  |
| `virtual_coffee_bot:this_weeks_events` | Every Monday at 8am UTC              | Lists all the meetings starting that week             | `0 8 * * *`  |

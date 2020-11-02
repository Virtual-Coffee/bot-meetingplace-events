# Virtual Coffee Bot

This friendly bot reports when the next event is.

It pulls the data from the [Meeting Place API](https://meetingplace.io/api/v1/group/virtual-coffee/events.json).

## Sample Output

![image](https://user-images.githubusercontent.com/325384/97884868-81de8380-1d1e-11eb-9a6f-0a6f9f2d1b7e.png)

```
📅 *Next Event:* Virtual Coffee - Morning Crowd
Starting in 10 minutes! <https://meetingplace.io/virtual-coffee/events/3185|View Details>
```

## Setting up

The bot runs on a schedule as managed by the GitHub Actions. They require the following [secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets) to be setup:

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

Currently there are two scheduled tasks which run:

| Rake Task                              | When it's run                      | Purpose                                               |
| -------------------------------------- | ---------------------------------- | ----------------------------------------------------- |
| `virtual_coffee_bot:next_event`        | Hourly ~10 minutes before the hour | Gives a heads up that a new meeting is about to start |
| `virtual_coffee_bot:this_weeks_events` | Every Monday at 8am UTC            | Lists all the meetings starting that week             |

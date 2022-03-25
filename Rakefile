$LOAD_PATH.unshift(File.dirname(__FILE__))

task :environment do
  require "dotenv/load"
  require "lib/meetingplace_slack_bot"
end

namespace :meetingplace_slack_bot do
  desc "Posts to Slack if an event is starting in the next 15 minutes"
  task :next_event, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::NextEvent.new.call(args[:channel], args[:group])
    end
  end

  desc "Posts to Slack if an event occouring today (Does not run on Monday)"
  task :todays_events, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::TodaysEvents.new.call(args[:channel], args[:group])
    end
  end

  desc "Posts to Slack the events for this week (Only runs on Monday)"
  task :this_weeks_events, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call(args[:channel], args[:group])
    end
  end

  desc "Gets a description of the group"
  task :info, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::GroupInfo.new.call(args[:channel], args[:group])
    end
  end

  # Call this every hour to update the status of the events
  # rake meetingplace_slack_bot:event_report["test-meetingplace","women-in-robotics", 8]
  desc "Send event reminders for group"
  task :event_report, [:channel, :group, :hour] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
      return
    end
    publish_report(args[:group], args[:channel], args[:hour])
  end

  desc "Loop through all chapters in config file and send reports"
  task :send_reports => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
      return
    end
    config = JSON.parse(File.read('config.json'))
    puts config
    config.collect do |chapter|
      publish_report(chapter["meetingplace_group"], chapter["slack_channel"], chapter["time"])
    end
  end

  def publish_report(group, channel, hour)
    puts "Publishing NextEvent for #{group} on #{channel}"
    # Query the next event each call
    MeetingplaceSlackBot::Reports::NextEvent.new.call(channel, group)
    # If the time is [time] am and it's monday, send this weeks events to slack
    if Time.now.utc.hour == hour.to_i
      puts "Checking daily reports for #{group} on #{channel} on #{args[:hour]}"
      if Time.now.monday?
        # Give the weekly report on mondays
        puts "Publishing ThisWeeksEvents for #{group} on #{channel}"
        MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call(channel, group)
      else
        # Show events happening today.
        puts "Publishing TodaysEvents for #{group} on #{channel}"
        MeetingplaceSlackBot::Reports::TodaysEvents.new.call(channel, group)
      end
    end
  end
end

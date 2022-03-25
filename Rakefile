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
    elsif Time.now.monday?
      puts "This doesn't run on Monday"
    else
      MeetingplaceSlackBot::Reports::TodaysEvents.new.call(args[:channel], args[:group])
    end
  end

  desc "Posts to Slack the events for this week (Only runs on Monday)"
  task :this_weeks_events, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    elsif !Time.now.monday?
      puts "This only runs on Monday"
    else
      MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call(args[:channel], args[:group])
    end
  end

  # Call this every hour to update the status of the events
  # rake meetingplace_slack_bot:event_report["test-meetingplace","women-in-robotics", 8]
  desc "Set up event reminders for group"
  task :event_report, [:channel, :group, :hour] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
      return
    end
    puts "Runing event_report for #{args[:group]} on #{args[:channel]}"
    # Query the next event each call
    MeetingplaceSlackBot::Reports::NextEvent.new.call(args[:channel], args[:group])
    # If the time is [time] am and it's monday, send this weeks events to slack
    if Time.now.utc.hour == args[:hour].to_i
      puts "Running event_report daily tasks for #{args[:group]} on #{args[:channel]} on #{args[:hour]}"
      if Time.now.monday?
        # Give the weekly report on mondays
        puts "Running event_report ThisWeeksEvents for #{args[:group]} on #{args[:channel]}"
        MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call(args[:channel], args[:group])
      else
        # Show events happening today.
        puts "Running event_report TodaysEvents for #{args[:group]} on #{args[:channel]}"
        MeetingplaceSlackBot::Reports::TodaysEvents.new.call(args[:channel], args[:group])
      end
    end
  end

  desc "Gets a description of the config"
  task :info, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::GroupInfo.new.call(args[:channel], args[:group])
    end
  end
end

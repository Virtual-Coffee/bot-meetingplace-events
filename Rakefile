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

  desc "Gets a description of the config"
  task :info, [:channel, :group] => :environment do |task, args|
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::GroupInfo.new.call(args[:channel], args[:group])
    end
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))

task :environment do
  require "dotenv/load"
  require "lib/meetingplace_slack_bot"
end

namespace :meetingplace_slack_bot do
  desc "Posts to Slack if an event is starting in the next 15 minutes"
  task next_event: :environment do
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::NextEvent.new.call
    end
  end

  desc "Posts to Slack if an event occouring today (Does not run on Monday)"
  task todays_events: :environment do
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    elsif Time.now.monday?
      puts "This doesn't run on Monday"
    else
      MeetingplaceSlackBot::Reports::TodaysEvents.new.call
    end
  end

  desc "Posts to Slack the events for this week (Only runs on Monday)"
  task this_weeks_events: :environment do
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    elsif !Time.now.monday?
      puts "This only runs on Monday"
    else
      MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call
    end
  end

  desc "Gets a description of the config"
  task info: :environment do
    if !ENV["SLACK_API_TOKEN"]
      puts "Missing required ENV: SLACK_API_TOKEN"
    else
      MeetingplaceSlackBot::Reports::Info.new.call
    end
  end
end

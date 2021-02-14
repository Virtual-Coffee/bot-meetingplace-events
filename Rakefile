$LOAD_PATH.unshift(File.dirname(__FILE__))

task :environment do
  require "dotenv/load"
  require "lib/meetingplace_slack_bot"
end

namespace :meetingplace_slack_bot do
  desc "Posts to Slack if an event is starting in the next 15 minutes"
  task next_event: :environment do
    if ENV["SLACK_API_TOKEN"]
      MeetingplaceSlackBot::Reports::NextEvent.new.call
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end

  desc "Posts to Slack if an event occouring today (Does not run on Monday)"
  task todays_events: :environment do
    if !Time.now.monday? && ENV["SLACK_API_TOKEN"]
      MeetingplaceSlackBot::Reports::TodaysEvents.new.call
    elsif Time.now.monday?
      puts "This doesn't run on Monday"
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end

  desc "Posts to Slack the events for this week (Only runs on Monday)"
  task this_weeks_events: :environment do
    if Time.now.monday? && ENV["SLACK_API_TOKEN"]
      MeetingplaceSlackBot::Reports::ThisWeeksEvents.new.call
    elsif !Time.now.monday?
      puts "This only runs on Monday"
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end
end

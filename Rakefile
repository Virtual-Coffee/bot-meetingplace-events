$LOAD_PATH.unshift(File.dirname(__FILE__))

task :environment do
  require "dotenv/load"
  require "lib/virtual_coffee_bot"
end

namespace :virtual_coffee_bot do
  desc "Posts to Slack if an event is starting in the next 15 minutes"
  task next_event: :environment do
    if ENV["SLACK_API_TOKEN"]
      VirtualCoffeeBot::Reports::NextEvent.new.call
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end

  desc "Posts to Slack if an event occouring today"
  task todays_events: :environment do
    if ENV["SLACK_API_TOKEN"]
      VirtualCoffeeBot::Reports::TodaysEvents.new.call
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end

  desc "Posts to Slack the events for this week"
  task this_weeks_events: :environment do
    if ENV["SLACK_API_TOKEN"]
      VirtualCoffeeBot::Reports::ThisWeeksEvents.new.call
    else
      puts "Missing required ENV: SLACK_API_TOKEN"
    end
  end
end

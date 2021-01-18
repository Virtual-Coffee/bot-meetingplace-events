require "spec_helper"

describe VirtualCoffeeBot::Reports::TodaysEvents do
  let(:instance) { described_class.new }
  let(:slack_client) { double :slack_client }
  let(:all_events) do
    JSON.parse(File.read("spec/fixtures/files/meetingplace.io/events.json")).collect do |event|
      MeetingPlace::Event.new(event)
    end
  end
  let(:start_of_event_day) { all_events.first.start_time.beginning_of_day }

  before do
    allow(instance).to receive(:slack_client).and_return(slack_client)
    allow(instance).to receive(:all_events).and_return(all_events)
  end

  describe "#call" do
    subject { instance.call }

    it "When called at the start of the day (before the event), posts a notice" do
      Timecop.travel(start_of_event_day) do
        expect(slack_client).to receive(:chat_postMessage)
        expect { subject }.to_not raise_error
      end
    end

    it "When called before the event, does not posts a notice" do
      Timecop.travel(start_of_event_day - 1.days) do
        expect(slack_client).to_not receive(:chat_postMessage)
        expect { subject }.to_not raise_error
      end
    end
  end
end

require 'spec_helper'

describe VirtualCoffeeBot::Reports::NextEvent do
  let(:instance) { described_class.new }
  let(:slack_client) { double :slack_client }
  let(:all_events) do
    JSON.parse(File.read('spec/fixtures/files/meetingplace.io/events.json')).collect do |event|
      MeetingPlace::Event.new(event)
    end
  end
  let(:next_event) { all_events.first.start_time }

  before do
    allow(instance).to receive(:slack_client).and_return(slack_client)
    allow(instance).to receive(:all_events).and_return(all_events)
  end

  describe '#call' do
    subject { instance.call }

    it 'When called 15 minutes before the event, posts a notice' do
      Timecop.travel(next_event - 15.minutes) do
        expect(slack_client).to receive(:chat_postMessage)
        expect { subject }.to_not raise_error
      end
    end

    it 'When called 15 minutes after the event starts, does not post a notice' do
      Timecop.travel(next_event + 15.minutes) do
        expect(slack_client).to_not receive(:chat_postMessage)
        expect { subject }.to_not raise_error
      end
    end
  end
end

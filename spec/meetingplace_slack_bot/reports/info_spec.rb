require "spec_helper"

describe MeetingplaceSlackBot::Reports::Info do
  let(:instance) { described_class.new }
  let(:slack_client) { double :slack_client }

  before do
    allow(instance).to receive(:slack_client).and_return(slack_client)
  end

  describe "#call" do
    subject { instance.call }

    it "When called, posts a notice" do
      expect(slack_client).to receive(:chat_postMessage)
      expect { subject }.to_not raise_error
    end
  end
end

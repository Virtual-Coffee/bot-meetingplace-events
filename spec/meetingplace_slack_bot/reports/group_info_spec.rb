require "spec_helper"

describe MeetingplaceSlackBot::Reports::GroupInfo do
  let(:instance) { described_class.new }
  let(:slack_client) { double :slack_client }
  let(:info) { MeetingPlace::Info.new("virtual-coffee") }

  before do
    allow(instance).to receive(:slack_client).and_return(slack_client)
    allow(instance).to receive(:info).and_return(info)
    info.instance_variable_set("@data", JSON.parse(File.read("spec/fixtures/files/meetingplace.io/info.json")))
  end

  describe "#call" do
    subject { instance.call }

    it "When called, posts a notice" do
      expect(slack_client).to receive(:chat_postMessage)
      expect { subject }.to_not raise_error
    end
  end
end

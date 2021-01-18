require "spec_helper"

describe MeetingPlace::Events do
  let(:instance) { described_class.new("virtual-coffee") }
  let(:events_json) { File.read("spec/fixtures/files/meetingplace.io/events.json") }
  let!(:events_endpoint) do
    stub_request(:get, "https://meetingplace.io/api/v1/group/virtual-coffee/events.json")
      .and_return(status: 200, body: events_json)
  end

  describe "#call" do
    subject { instance.call }

    it do
      is_expected.to all(be_a(MeetingPlace::Event))
      expect(events_endpoint).to have_been_requested.times(1)
    end
  end
end

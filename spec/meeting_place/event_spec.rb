require "spec_helper"

describe MeetingPlace::Event do
  let(:events) { JSON.parse(File.read("spec/fixtures/files/meetingplace.io/events.json")) }
  let(:instance) { described_class.new(events.first) }

  describe "#formated_start_time" do
    subject { instance.formated_start_time }

    it { is_expected.to eq "Tuesday 3rd @ 09:00 AM (-0500)" }
  end
end

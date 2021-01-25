require "spec_helper"

describe MeetingPlace::Event do
  let(:events) { JSON.parse(File.read("spec/fixtures/files/meetingplace.io/events.json")) }
  let(:instance) { described_class.new(events.first) }

  describe "#slack_markdown_start_time" do
    subject { instance.slack_markdown_start_time }

    it { is_expected.to eq "<!date^1604412000^{date_short_pretty} @ {time}^https://meetingplace.io/virtual-coffee/events/3185|Tuesday 3rd @ 09:00 AM (-0500)>" }
  end

  describe "#time_to_start" do
    subject { instance.time_to_start }

    it do
      Timecop.travel(instance.start_time - 14.minutes - 30.seconds) do
        is_expected.to eq "14 minutes"
      end
    end
  end
end

require "spec_helper"

describe MeetingPlace::Info do
  let(:info_json) { File.read("spec/fixtures/files/meetingplace.io/info.json") }
  let!(:info_endpoint) do
    stub_request(:get, "https://meetingplace.io/api/v1/group/virtual-coffee.json")
      .and_return(status: 200, body: info_json)
  end
  let(:instance) { described_class.new("virtual-coffee") }

  describe "#name" do
    subject { instance.name }
    it { is_expected.to eq "Virtual Coffee" }
  end

  describe "#url" do
    subject { instance.url }
    it { is_expected.to eq "https://meetingplace.io/virtual-coffee" }
  end

  describe "#short_description" do
    subject { instance.short_description }
    it { is_expected.to eq "An intimate community for all devs, optimized for you" }
  end
end

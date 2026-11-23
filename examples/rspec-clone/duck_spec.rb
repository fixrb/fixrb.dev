require "r_spec"

# A duck, in the words of RSpec.
class Duck
  def walk = "Klop klop!"
  def swim = "Swoosh..."
end

RSpec.describe Duck do
  subject { described_class.new }

  its(:walk) { is_expected.to eq "Klop klop!" }
  its(:swim) { is_expected.to eq "Swoosh..." }

  context "when asked to speak" do
    its(:speak) { is_expected.to raise_exception NoMethodError }
  end

  it "walks before it swims" do
    expect(subject.walk).to match(/Klop/)
    expect { subject.swim }.not_to raise_exception StandardError
  end

  pending "flies"
end

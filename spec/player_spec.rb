require 'spec_helper'

describe Player do
  subject { Player.new(name: 'Martin', turns: turns) }
  let(:turns) do
    %w{10 10 10 10 10 10 10 10 10 10 10 10}
  end
  describe '.accumulated_scores' do
    let(:expected_response) do
      [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
    end
    it { expect(subject.accumulated_scores).to eql expected_response}
  end

  describe '.decorate_frames' do
    let(:expected_response) do
      ["\tX", "\tX", "\tX", "\tX", "\tX", "\tX", "\tX", "\tX", "\tX", "X\tX\tX"]
    end
    it { expect(subject.decorate_frames).to eql expected_response}
  end
end
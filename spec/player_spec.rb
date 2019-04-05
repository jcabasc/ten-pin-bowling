# frozen_string_literal: true

require 'spec_helper'
describe Player do
  subject { Player.new(name: 'Martin', turns: turns) }
  let(:turns) { %w[10 10 10 10 10 10 10 10 10 10 10 10] }

  describe '.accumulated_scores' do
    let(:expected_response) do
      [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
    end
    it { expect(subject.accumulated_scores).to eql expected_response }
  end

  describe '.decorate_frames' do
    let(:expected_response) do
      %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX X\tX\tX]
    end
    it { expect(subject.decorate_frames).to eql expected_response }
  end

  describe 'validations' do
    let(:turns) { %w[7 9 10 10 10 10 10 10 10 10 10 10 10] }
    let(:error_msg) do
      "#{subject.name} can't knock down more than 10 pins in a single frame."
    end
    before { subject.valid? }
    it { expect(subject.errors.full_messages.pop).to eql error_msg }
  end
end

# frozen_string_literal: true

require 'spec_helper'
describe Player do
  subject { Player.new(name: 'Martin', rolls: rolls) }

  describe '.accumulated_scores' do
    context 'when perfect score' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 10 10 10] }
      let(:expected_response) do
        [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      end
      it { expect(subject.accumulated_scores).to eql expected_response }
    end

    context 'when regular score' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 8 2 2] }
      let(:expected_response) do
        [30, 60, 90, 120, 150, 180, 210, 238, 258, 270]
      end
      it { expect(subject.accumulated_scores).to eql expected_response }
    end
  end

  describe '.decorate_frames' do
    context 'when sum rolls is 10' do
      let(:rolls) { %w[8 2 4 5 10 10 10 10 10 10 10 10 10 10] }
      let(:expected_response) do
        %W[8\t/ 4\t5 \tX \tX \tX \tX \tX \tX \tX X\tX\tX]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end

    context 'when sum rolls is 10 for the first pair in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 8 2 5] }
      let(:expected_response) do
        %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX 8\t/\t5]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end

    context 'when sum rolls is 10 for the second pair in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 10 2 8] }
      let(:expected_response) do
        %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX X\t2\t/]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end

    context 'when last frame has only 2 rolls' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 2 8] }
      let(:expected_response) do
        %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX 2\t/]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end

    context 'when player miss a roll in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 10 F 8] }
      let(:expected_response) do
        %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX X\tF\t8]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end

    context 'when player miss the last roll in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 10 10 0] }
      let(:expected_response) do
        %W[\tX \tX \tX \tX \tX \tX \tX \tX \tX X\tX\t0]
      end
      it { expect(subject.decorate_frames).to eql expected_response }
    end
  end

  describe 'validations' do
    before { subject.valid? }

    context 'when an uncompleted number of frames were input' do
      let(:rolls) { %w[6 4 10 10 10 10 10 10 10 3 5] }
      let(:message) do
        I18n.t('player.errors.invalid_size_of_frames', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end

    context 'when invalid sum roll for regular frames' do
      let(:rolls) { %w[7 9 10 10 10 10 10 10 10 10 10 10 10] }
      let(:message) do
        I18n.t('player.errors.invalid_sum_roll', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end

    context 'when invalid sum roll for pairs in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 8 9] }
      let(:message) do
        I18n.t('player.errors.invalid_sum_roll_for_pairs', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end

    context 'when third roll is not allowed in the last frame' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 8 1 10] }
      let(:message) do
        I18n.t('player.errors.third_roll_not_allowed', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end

    context 'when there is one missing roll in the last frame' do
      let(:rolls) { %w[6 4 10 10 10 10 10 10 10 10 3 7] }
      let(:message) do
        I18n.t('player.errors.missing_third_roll', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end

    context 'when last frame has more than 3 rolls' do
      let(:rolls) { %w[10 10 10 10 10 10 10 10 10 8 2 10 10 10] }
      let(:message) do
        I18n.t('player.errors.rolls_number_invalid', name: subject.name)
      end
      it { expect(subject.errors.full_messages.pop).to eql message }
    end
  end
end

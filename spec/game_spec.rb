# frozen_string_literal: true

require 'spec_helper'
describe Game do
  let(:rolls_by_player) do
    File
      .readlines(path)
      .reject { |line| line == "\n" }
      .collect { |pf| pf.delete("\n").split("\t") }
  end
  subject { Game.new(rolls: rolls_by_player) }

  describe 'execute' do
    context 'success' do
      before { subject.execute }
      context 'when perfect score' do
        let(:path) { './spec/fixtures/perfect_score.txt' }
        let(:expected_response) { FixtureSupport.perfect_score_response }
        it { expect(subject.final_output).to eql expected_response }
      end

      context 'when all rolls are 0 and/or fouls' do
        let(:path) { './spec/fixtures/zero_rolls.txt' }
        let(:expected_response) { FixtureSupport.all_rolls_zero_response }
        it { expect(subject.final_output).to eql expected_response }
      end

      context 'when regular score' do
        let(:path) { './spec/fixtures/normal_scores.txt' }
        let(:expected_response) { FixtureSupport.regular_score_response }
        it { expect(subject.final_output).to eql expected_response }
      end
    end

    context 'failure' do
      let(:path) { './spec/fixtures/invalid_sum_roll.txt' }
      let(:message) do
        I18n.t('player.errors.invalid_sum_roll', name: 'Martin') + "\n"
      end
      it { expect { subject.execute }.to output(message).to_stdout }
    end
  end

  describe 'validations' do
    context 'when invalid input' do
      let(:path) { './spec/fixtures/invalid_input.txt' }
      let(:error_msg) do
        I18n.t('game.errors.invalid_input')
      end
      before { subject.valid? }
      it do
        expect(subject.errors.full_messages.pop).to eql error_msg
      end
    end
  end
end

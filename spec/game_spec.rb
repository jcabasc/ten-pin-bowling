require 'spec_helper'

describe Game do
  let(:turns_by_player) do
    File
      .readlines(path)
      .select{|line| line != "\n" }
      .collect{ |pf| pf.gsub("\n", '').split("\t") }
  end
  subject { Game.new(turns: turns_by_player) }

  describe 'execute' do
    context 'when perfect score' do
      let(:path) { './spec/fixtures/perfect_score.txt' }
      before { subject.execute }
      it do
        expect(subject.final_output).to eql FixtureSupport.perfect_score_response
      end
    end

    context 'when all rolls are 0 and/or fouls' do
      let(:path) { './spec/fixtures/zero_rolls.txt' }
      before { subject.execute }
      it do
        expect(subject.final_output).to eql FixtureSupport.all_rolls_zero_response
      end
    end

    context 'when regular score' do
      let(:path) { './spec/fixtures/normal_scores.txt' }
      before { subject.execute }
      it do
        expect(subject.final_output).to eql FixtureSupport.regular_score_response
      end
    end
  end

  describe 'validations' do

    context 'when invalid input' do
      let(:path) { './spec/fixtures/invalid_input.txt' }
      let(:error_msg) { 'Please check your input for an invalid value or a row thas is not tab-separated.' }
      before { subject.valid? }
      it do
        expect(subject.errors.full_messages.pop).to eql error_msg
      end
    end
  end
end
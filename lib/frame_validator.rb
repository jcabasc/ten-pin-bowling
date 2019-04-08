# frozen_string_literal: true

require 'active_model'

class FrameValidator < ActiveModel::Validator # :nodoc:
  def validate(record)
    Validator.new(record).valid?
  end

  class Validator # :nodoc:
    attr_reader :record, :frames

    def initialize(record)
      @record = record
      @frames = record.frames.map { |fr| fr.map(&:to_i) }
                      .reject(&:empty?)
    end

    def valid?
      valid_rolls?
      completed_frames?
      rolls_are_valid_within_last_frame?
      rolls_number_is_expected_within_last_frame
      missing_roll_within_last_frame
      rolls_are_not_greater_than_maximum_allowed_within_last_frame
      record.errors.empty?
    end

    private

    def last_frame
      @last_frame ||= frames.last
    end

    def completed_frames?
      msg = I18n
            .t('player.errors.invalid_size_of_frames', name: record.name)
      record.errors.add(:base, msg) if frames.size < 10
    end

    def valid_rolls?
      invalid_score = frames[0..frames.size - 2].detect do |rolls|
        rolls.reduce(:+) > 10
      end
      msg = I18n
            .t('player.errors.invalid_sum_roll', name: record.name)
      record.errors.add(:base, msg) if invalid_score.present?
    end

    def rolls_are_valid_within_last_frame?
      msg = I18n
            .t('player.errors.invalid_sum_roll_for_pairs', name: record.name)
      invalid_score = [last_frame[0..1], last_frame[1..2]].detect do |fr|
        next if fr.size == 1

        fr[0] != 10 && fr.reduce(:+) > 10
      end
      record.errors.add(:base, msg) if invalid_score.present?
    end

    def rolls_number_is_expected_within_last_frame
      return if last_frame.size < 3

      msg = I18n
            .t('player.errors.third_roll_not_allowed', name: record.name)
      record.errors.add(:base, msg) if last_frame[0..1].reduce(:+) < 10
    end

    def missing_roll_within_last_frame
      return if last_frame.size == 3

      msg = I18n
            .t('player.errors.missing_third_roll', name: record.name)
      sum = last_frame[0..1].reduce(:+)
      record.errors.add(:base, msg) if [10, 20].include?(sum)
    end

    def rolls_are_not_greater_than_maximum_allowed_within_last_frame
      msg = I18n
            .t('player.errors.rolls_number_invalid', name: record.name)
      record.errors.add(:base, msg) if last_frame.size > 3
    end
  end
end

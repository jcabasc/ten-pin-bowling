# frozen_string_literal: true

require 'active_model'
class Player # :nodoc:
  include ActiveModel::Model
  attr_reader :name, :turns, :scores, :frames
  validate :valid_scores?
  def initialize(name:, turns:)
    @name = name
    @turns = turns
    @frames = calculate_frames
    @scores = calculate_scores
  end

  def accumulated_scores
    scores.map.with_index { |_fr, i| scores[0..i].reduce(:+) }
  end

  def decorate_frames
    frames.map do |frame|
      sum = frame.map(&:to_i).reduce(:+)
      next frame.join("\t").gsub('10', 'X') if sum != 10

      next "\tX" if frame.size == 1

      [frame[0], '/'].join("\t")
    end
  end

  private

  def calculate_frames
    [].tap do |frames|
      frame = []
      frames << loop do
        break turns[0..turns.size - 1] if frames.size == 9

        frame << turns.shift
        next unless frame.map(&:to_i).reduce(:+) == 10 || frame.size > 1

        frames << frame
        frame = []
      end
    end
  end

  def calculate_scores
    frames.map.with_index do |frame, index|
      sum = frame.map(&:to_i).reduce(:+)
      next sum if sum != 10

      next sum + frames[index + 1][0].to_i if frame.count > 1

      sum + frames[index + 1..index + 2].flatten[0..1].map(&:to_i)
                                        .reduce(:+)
    end
  end

  def valid_scores?
    invalid_score = frames[0..frames.size - 2].detect do |scores|
      scores.map(&:to_i).reduce(:+) > 10
    end
    msg = "#{name} can't knock down more than 10 pins in a single frame."
    errors.add(:base, msg) if invalid_score.present?
  end
end

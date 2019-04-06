# frozen_string_literal: true

require 'active_model'
class Player # :nodoc:
  include ActiveModel::Validations
  attr_reader :name, :rolls, :scores, :frames
  validates_with FrameValidator

  def initialize(name:, rolls:)
    @name = name
    @rolls = rolls
    @frames = calculate_frames
    @scores = calculate_scores
  end

  def accumulated_scores
    scores.map.with_index { |_fr, i| scores[0..i].reduce(:+) }
  end

  def decorate_frames
    decorated_frames = frames[0..frames.size - 2].map do |frame|
      sum = frame.map(&:to_i).reduce(:+)
      next frame.join("\t").gsub('10', 'X') if sum != 10

      next "\tX" if frame.size == 1

      [frame[0], '/'].join("\t")
    end

    decorated_frames + decorate_last_frame(frames.last)
  end

  private

  def decorate_last_frame(frame)
    spare = false
    str = frame.map.with_index do |roll, index|
      next roll if index.zero? || frame[index - 1].to_i == 10 || spare == true

      if frame[index - 1].to_i + roll.to_i == 10
        spare = true
        next '/'

      end
      roll
    end
    [str.join("\t").gsub('10', 'X')]
  end

  def calculate_frames
    [].tap do |frames|
      frame = []
      frames << loop do
        break rolls[0..rolls.size - 1] if frames.size == 9

        frame << rolls.shift
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

      next sum + frames[index + 1][0].to_i if frame.count > 1 && index != 9

      sum + frames[index + 1..index + 2].flatten[0..1].map(&:to_i)
                                        .reduce(:+).to_i
    end
  end
end

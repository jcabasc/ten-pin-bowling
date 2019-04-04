require 'active_model'

class Player
  include ActiveModel::Model
  attr :name, :turns, :scores, :frames
  validate :valid_scores?
  STRIKE = '10'
  def initialize(name:, turns:)
    @name = name
    @turns = turns
    @frames = calc_frames
    @scores = calc_scores
  end

  def accumulated_scores
    scores.map.with_index{|fr, i| scores[0..i].reduce(:+) }
  end

  def decorate_frames
    frames.map do |pinfall|
      sum = pinfall.map(&:to_i).reduce(:+)
      if sum == 10
        if pinfall.count == 1
          "\tX"
        else
          [pinfall[0], '/'].join("\t")
        end
      else
        pinfall.join("\t").gsub('10', 'X')
      end
    end
  end

  private

  def calc_frames
    [].tap do |frames|
      number_of_frames = 1
      index = 0
      loop do
        frames << turns[index..index+2] if number_of_frames == 10
        number_of_frames+=1
        break if number_of_frames > 10

        if roll_is_a_strike?(index)
          frames << %W{#{turns[index]}}
          index+=1
        else
          frames << turns[index..index+1]
          index+=2
        end
      end
    end
  end

  def calc_scores
    frames.map.with_index do |fr, index|
      sum = fr.map(&:to_i).reduce(:+)
      if sum == 10
        if fr.count > 1
          sum + frames[index+1][0].to_i
        else
          sum + frames[index+1..index+2].flatten[0..1].map(&:to_i).reduce(:+)
        end
      else
        sum
      end
    end
  end

  def roll_is_a_strike?(index)
    turns[index] == STRIKE
  end

  def valid_scores?
    invalid_score = frames[0..frames.size-2].detect do |scores|
      scores.map(&:to_i).reduce(:+) > 10
    end
    errors.add(:base, "#{name} can't knock down more than 10 pins in a single frame.") if invalid_score.present?
  end
end
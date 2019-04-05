# frozen_string_literal: true

require 'active_model'
class Game # :nodoc:
  include ActiveModel::Model
  attr_reader :turns, :final_output
  validate :valid_input?
  VALID_INPUT = ('0'..'10').to_a + %w[F]
  def initialize(turns:)
    @turns = turns
    @final_output = %w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t") + "\n"
  end

  def execute
    player_names.each do |name|
      player_rolls = turns
                     .select { |turn| turn[0] == name }
                     .map { |pinfall| pinfall[1] }
      player = Player.new(name: name, turns: player_rolls)
      next generate_dynamic_output_for(player) if player.valid?

      return puts player.errors.full_messages
    end

    print_output
  end

  private

  def player_names
    turns.map { |t| t[0] }.uniq
  end

  def add_output(str, new_line = true)
    str += "\n" if new_line
    final_output << str
  end

  def print_output
    puts final_output
  end

  def generate_dynamic_output_for(player)
    add_output(player.name)
    add_output("Pinfalls\t", false)
    add_output(player.decorate_frames.join("\t"))
    add_output("Score\t\t", false)
    add_output(player.accumulated_scores.join("\t\t"))
  end

  def valid_input?
    invalid_input = turns.map(&:last).detect do |pinfall|
      !VALID_INPUT.include?(pinfall)
    end
    msg = 'Please check your input for an invalid value or a'\
    ' row that is not tab-separated.'
    errors.add(:base, msg) if invalid_input.present?
  end
end

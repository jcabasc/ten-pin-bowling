# frozen_string_literal: true

require 'active_model'
class Game # :nodoc:
  include ActiveModel::Model
  attr_reader :rolls, :final_output
  validate :valid_input?
  VALID_INPUT = ('0'..'10').to_a + %w[F]
  def initialize(rolls:)
    @rolls = rolls
    @final_output = %w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t") + "\n"
  end

  def execute
    player_names.each do |name|
      player_rolls = rolls
                     .select { |roll| roll[0] == name }
                     .map { |pinfall| pinfall[1] }
      player = Player.new(name: name, rolls: player_rolls)
      next generate_dynamic_output_for(player) if player.valid?

      return puts player.errors.full_messages
    end

    print_output
  end

  private

  def player_names
    rolls.map { |t| t[0] }.uniq
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
    invalid_input = rolls.map(&:last).detect do |pinfall|
      !VALID_INPUT.include?(pinfall)
    end
    msg = I18n.t('game.errors.invalid_input')
    errors.add(:base, msg) if invalid_input.present?
  end
end

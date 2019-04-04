require 'active_model'
class Game
  include ActiveModel::Model
  attr :turns, :final_output
  validate :valid_input?
  VALID_INPUT = ('0'..'10').to_a + %w{F}
  def initialize(turns:)
    @turns = turns
    @final_output = ''
  end

  def execute
    player_names = turns.map{|t| t[0]}.uniq
    add_output(%w{Frame 1 2 3 4 5 6 7 8 9 10}.join("\t\t"))

    player_names.each do |name|
      player_turns = turns.select{|turn| turn[0] == name }.map{|pinfall| pinfall[1] }
      player = Player.new(name: name, turns: player_turns)
      if player.valid?
        generate_dynamic_output_for(player)
      else
        puts player.errors.full_messages
      end
    end

    print_output
  end

  private

  def add_output(str, new_line = true)
    str = str + "\n" if new_line
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
    errors.add(:base, 'Please check your input for an invalid value or a row thas is not tab-separated.') if invalid_input.present?
  end

end
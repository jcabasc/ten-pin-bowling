# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'
require 'rubygems'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

namespace :ten_pin_bowling do
  task :start do
    file_path = ARGV[1]
    if file_path.present?
      turns = File.readlines(file_path).reject { |line| line == "\n" }
      game = Game.new(turns: turns.collect { |pf| pf.delete("\n").split("\t") })

      if game.valid?
        game.execute
      else
        puts game.errors.full_messages
      end
    else
      puts 'You must provide a file path by running for instance'\
           ' `rake ten_pin_bowling:start scores.txt`'
    end
  end
end

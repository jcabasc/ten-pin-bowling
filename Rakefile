require 'bundler/setup'
require 'byebug'
require 'rubygems'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

namespace :ten_pin_bowling do
  task :start do
    file_path = ARGV[1]
    unless file_path.nil?
      turns = File.readlines(file_path).select{|line| line != "\n" }
      game = Game.new(turns: turns.collect{|pf| pf.gsub("\n", '').split("\t") })

      if game.valid?
        game.execute
      else
        puts game.errors.full_messages
      end
    else
      puts 'You must provide a file path by running for instance `rake ten_pin_bowling:start scores.txt`'
    end
  end
end
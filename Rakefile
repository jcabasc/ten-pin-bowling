require 'bundler/setup'
require 'byebug'
require 'rubygems'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

namespace :ten_pin_bowling do
  task :start do
    file_path = ARGV[1]
    unless file_path.nil?
      pinfalls = File.readlines(file_path).select{|line| line != "\n" }
      game = Game.new(turns: pinfalls.collect{|pf| pf.gsub("\n", '').split("\t") })

      if game.valid?
        player_names = game.turns.map{|t| t[0]}.uniq
        game.add_output(%w{Frame 1 2 3 4 5 6 7 8 9 10}.join("\t\t"))

        player_names.each do |name|
          player_turns = game.turns.select{|turn| turn[0] == name }.map{|pinfall| pinfall[1] }
          player = Player.new(name: name, turns: player_turns)
          player.calc_frames
          player.calc_scores
          if player.valid?
            game.generate_dynamic_output_for(player)
          else
            puts player.errors.full_messages
          end
        end
        puts "equal perfect_score.txt\n\n" if game.final_output == "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nCarl\nPinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\nScore\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\n"
        puts "equal scores.txt\n\n" if game.final_output == "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJeff\nPinfalls\t\tX\t7\t/\t9\t0\t\tX\t0\t8\t8\t/\tF\t6\t\tX\t\tX\tX\t8\t1\nScore\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\nJohn\nPinfalls\t3\t/\t6\t3\t\tX\t8\t1\t\tX\t\tX\t9\t0\t7\t/\t4\t4\tX\t9\t0\nScore\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\n"
        game.print_output
      else
        puts game.errors.full_messages
      end
    else
      puts 'You must provide a file path by running for instance `rake ten_pin_bowling:start scores.txt`'
    end
  end
end
require 'bundler/setup'
require 'byebug'
require 'rubygems'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

namespace :ten_pin_bowling do
  task :start do
    # ARGV.each { |a| task a.to_sym do ; end }

    file_path = ARGV[1]
    unless file_path.nil?
      file_pinfalls = File.readlines(file_path).select{|line| line != "\n" }

      #total pinfalls
      total_pinfalls = file_pinfalls.collect{|x| x.gsub("\n", '').split("\t") }

      players = total_pinfalls.map{|x| x[0]}.uniq

      #starting string with final output
      final_output = "Frame\t\t" + %w{1 2 3 4 5 6 7 8 9 10}.join("\t") + "\n"

      # mapping different players
      players.each do |name|
        # player = Player.new(name: name)
        number_of_frames = 1
        index = 0

        player_pinfalls = total_pinfalls.select{|pinfall| pinfall[0] == name }.map{|pinfall| pinfall[1] }

        # getting individual pinfalls by frame
        frames = [].tap do |frames|
          loop do
            frames << player_pinfalls[index..index+2] if player_pinfalls[index] == '10' && number_of_frames == 10
            number_of_frames+=1
            break if number_of_frames > 10
            if player_pinfalls[index] == '10'
              frames << %W{#{player_pinfalls[index]}}
              index+=1
            else
              frames << player_pinfalls[index..index+1]
              index+=2
            end
          end
        end

        #getting scores sum by frame
        scores = frames.map.with_index do |fr, index|
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

        #get accumulate scores array
        accum_scores = scores.map.with_index{|fr, i| scores[0..i].reduce(:+) }

        #printing output
        final_output << name + "\n"
        final_output << "Pinfalls\t"


        output_pinfalls = frames.map do |x|
          sum = x.map(&:to_i).reduce(:+)
          if x.count == 1 && sum == 10
            "  X"
          elsif x.count == 2 && sum == 10
            [x[0], '/'].join(" ")
          else
            x.join(" ").gsub('10', 'X')
          end
        end


        final_output << output_pinfalls.join("\t") + "\n"
        final_output << "Score\t\t" + accum_scores.join("\t") + "\n"

        puts "equal perfect_score.txt" if final_output == "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\nCarl\nPinfalls\t  X\t  X\t  X\t  X\t  X\t  X\t  X\t  X\t  X\tX X X\nScore\t\t30\t60\t90\t120\t150\t180\t210\t240\t270\t300\n"
        puts "equal scores.txt" if final_output == "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\nJeff\nPinfalls\t  X\t7 /\t9 0\t  X\t0 8\t8 /\tF 6\t  X\t  X\tX 8 1\nScore\t\t20\t39\t48\t66\t74\t84\t90\t120\t148\t167\nJohn\nPinfalls\t3 /\t6 3\t  X\t8 1\t  X\t  X\t9 0\t7 /\t4 4\tX 9 0\nScore\t\t16\t25\t44\t53\t82\t101\t110\t124\t132\t151\n"
      end
    else
      puts 'You must provide a file path by running for instance `rake ten_pin_bowling:start scores.txt`'
    end
  end
end
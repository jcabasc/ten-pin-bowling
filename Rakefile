# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'
require 'rubygems'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en

namespace :ten_pin_bowling do
  task :start do
    file_path = ARGV[1]
    if file_path.present?
      rolls = File
              .readlines(file_path)
              .reject { |line| line == "\n" }
              .collect { |pf| pf.delete("\n").tr("\t", ' ').split(' ') }
      game = Game.new(rolls: rolls)

      if game.valid?
        game.execute
      else
        puts game.errors.full_messages
      end
    else
      puts I18n.t('system.errors.no_file_present')
    end
  end
end

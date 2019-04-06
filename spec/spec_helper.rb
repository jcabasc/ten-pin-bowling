# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'rspec'
require_relative '../lib/game.rb'
require_relative '../lib/frame_validator.rb'
require_relative '../lib/player.rb'
require 'byebug'
require 'support'
require 'i18n'
include FixtureSupport

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en

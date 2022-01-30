#!/usr/bin/env ruby

require_relative '../lib/new_day.rb'

NewDay.new(notes_directory: ENV['NEW_DAY_DIR'] || "#{ ENV['HOME'] }/notes/").run

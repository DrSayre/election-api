require 'clockwork'
require "#{File.join(File.dirname(__FILE__))}/config/boot"
require "#{File.join(File.dirname(__FILE__))}/config/environment"

module Clockwork
  handler do |job|
    puts "Running #{job}\n#{File.join(File.dirname(__FILE__))}"
  end

  # every(15.minutes, 'Update numbers') { UpdateNumbersJob.perform_now }
  # every(4.hours, 'Update Twitter') { TweetStatusJob.perform_now }
  # every(1.day, 'Update Mean Sample') { UpdateMeanSampleJob.perform_now }
  # every(1.day, 'Positions expiring today emails', at: '09:00') { MultipleEmail.positions_expiring_today }
end

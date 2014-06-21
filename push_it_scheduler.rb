#!/usr/bin/env ruby

## run this from Procfile to push data to wombat periodically

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  system 'rake wombat:push_it'
end

scheduler.join

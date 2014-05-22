#!/usr/bin/env ruby
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  system 'rake wombat:push_it'
end

scheduler.join

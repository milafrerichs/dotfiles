#!/usr/bin/env ruby

require 'erb'
require 'date'

def doc
  "/Users/milafrerichs/Library/Mobile Documents/com~apple~CloudDocs/Planning/WeeklyPlanning.md"
end

def date_of_next(day)
  date  = Date.parse(day)
  delta = date > Date.today ? 0 : 7
  date + delta
end

def week_format(week)
  "#{week[0].strftime('%d.%m')} - #{week[6].strftime('%d.%m.%y')}"
end

def weekday(day)
  day.strftime("%A")
end

def weekday_day(day)
  day.strftime("%A, %d.%m")
end

def day_scheduled(day)
  day.strftime("%Y-%m-%d %a")
end

def write_at_beginning(filename, content)
  File.open(filename, "r+") do |file|
    lines = file.readlines
    file.rewind
    file.write(content)
    file.write(lines.join)
  end
end

module Planning
  def one_thing
    @thing ||= OneThing.new
  end

  def theme
    @theme ||= Theme.new
  end
end

# Read Calendar from iCloud and show events
class Week
  include Planning
  attr_reader :week, :days
  @@week_length = 5

  def initialize(this_week = false)
    @days = []
    monday = date_of_next("Monday")
    @week = (monday..(monday + 7)).to_a
    one_thing
    @@week_length.times do |index|
      @days << Day.new(@week[index])
    end
  end
end

class Day
  include Planning
  attr_reader :day, :quarters

  def initialize(day)
    @quarters = []
    @day = day
    puts "#{weekday_day(day)}:"
    one_thing
    theme
    4.times do |index|
      @quarters << Quarter.new(index+1)
    end
  end

  def to_s
    weekday(@day)
  end
end

class Thing
  @text = "Thing"

  def initialize
    puts "#{@text}:"
    @thing = gets.chomp
  end

  def to_s
    @thing
  end
end

class OneThing < Thing
  def initialize
    @text = "One Thing"
    super
  end
end

class Theme < Thing
  def initialize
    @text = "Theme"
    super
  end
end

class Quarter
  attr_reader :q

  def initialize(quarter)
    @q = quarter
    puts "Q #{quarter}:"
    @thing = gets.chomp
  end

  def to_s
    @thing
  end
end

def main
  @week = Week.new

  template_text = <<-EOF
  - # Week <%= week_format(@week.week)  %>
    - ## One thing
      planning:: onething
      heading:: 2
      - TODO <%= @week.one_thing %>
    - ## Top 5
      planning:: top5
      heading:: 2
    <%- @week.days.each do |day| -%>
      - TODO <%= day.one_thing %>
    <%- end -%>
    - ## Important Dates
      heading:: 2
      - Donnerstag: 
    <% @week.days.each do |day| %>
    - ## <%= day %>
      SCHEDULED: <<%= day_scheduled(day.day)%>>
      heading:: 2
      - ### One thing
        planning:: onething
        heading:: 3
        - TODO <%= day.one_thing %>
      - ### Theme
        planning:: theme
        heading:: 3
        - <%= day.theme %>
      - ### Top 4
        planning:: quarter
        heading:: 3
      <%- day.quarters.each do |q| -%>
        - Q<%= q.q %>: <%= q %>
          quarter:: <%= q.q %>
          success:: false
      <%- end -%>
    <% end %>
  EOF
  template = ERB.new(template_text, nil, '-')
  plan = template.result(binding)
  write_at_beginning(doc, plan)
end
main

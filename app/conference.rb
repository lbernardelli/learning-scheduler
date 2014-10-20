require_relative 'talk'
require_relative 'track'
require_relative 'exceptions/invalid_talk_exception'

class Conference
  attr_reader :tracks

  def initialize(file_name)
    @talks = Array.new
    @tracks = Array.new
    @file_name = file_name
  end

  def schedule
    load_talks()
    sort_talks_by_duration_desc()
    greedly_schedule(@talks)
  end

  def print_schedule
    schedule = String.new

    @tracks.each_with_index do |track, i|
      schedule += "Track #{i + 1} \n"
      schedule += track.print
    end

    return schedule
  end

  private

  def load_talks
    if File.exist?(@file_name)
      File.open(@file_name, "r") do |f|
        f.each_line do |line|
          begin
            @talks.push(Talk.new(line))
          rescue InvalidTalkException => e
            puts e.message
          end
        end
      end
    else
      raise InvalidFileException, "Sorry, the file #{@file_name} does not exist."
    end
  end

  def sort_talks_by_duration_desc
    @talks.sort_by! { |a| -a.duration }
  end

  def greedly_schedule(talks_to_schedule)
    talksNotAllocated = Array.new
    track = Track.new()
    
    talks_to_schedule.each do |talk|
      talksNotAllocated.push(talk) unless track.accept_talk(talk)
    end

    track.add_network_event
    @tracks.push(track)

    greedly_schedule(talksNotAllocated) unless talksNotAllocated.empty?
  end
end

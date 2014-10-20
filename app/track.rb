require_relative 'track_session'
require_relative 'morning_session'
require_relative 'afternoon_session'

class Track
  attr_reader :morning_session, :afternoon_session

  def initialize()
    @morning_session = MorningSession.new
    @afternoon_session = AfternoonSession.new
  end

  def accept_talk(talk)
  	accepted = @morning_session.accept_talk(talk)  	
    accepted = @afternoon_session.accept_talk(talk) unless accepted

    unless accepted
      unless is_possible_to_schedule_in_other_track?(talk)
        raise ImpossibleToScheduleTalkException, "Impossible to schedule talk with duration: #{talk.duration}"
      end
    end

    return accepted
  end

  def add_network_event
  	@afternoon_session.add_network_event
  end

  def print
  	talks = @morning_session.print
  	talks += @afternoon_session.print

  	return talks
  end

  private

  def is_possible_to_schedule_in_other_track?(talk)
    is_possible = true

    unless @morning_session.is_acceptable?(talk) && @afternoon_session.is_acceptable?(talk)
      is_possible = false
    end

    return is_possible
  end
end
require_relative 'track_session'
require_relative 'session_event'

class AfternoonSession < TrackSession
  
  NETWORK_EVENT_SUBJECT = "Network event"

  def initialize()
  	super()
    @session_duration_minutes = 240
    @session_start_time = 13
  end

  def add_network_event
    network_event = SessionEvent.new(NETWORK_EVENT_SUBJECT)

    if available_talk_duration >= 60
      network_event.start = Time.new(2014, 01, 01, 16, 00)
    else
      network_event.start = Time.new(2014, 01, 01, 17, 00)
    end

    @session_talks.push(network_event)

    return network_event
  end

  protected
  
  def session_start_time
    @session_start_time
  end
end
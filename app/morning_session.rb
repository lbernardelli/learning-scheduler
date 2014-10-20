require_relative 'track_session'

class MorningSession < TrackSession

  def initialize()
  	super()
    @session_duration_minutes = 180
    @session_start_time = 9
  end

  protected
  
  def session_start_time
    @session_start_time
  end
  
end
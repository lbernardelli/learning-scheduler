class TrackSession
  attr_reader :session_duration_minutes, :session_talks, :session_start_time

  def initialize()
    @session_talks = Array.new
  end

  def accept_talk(talk)
    accepted = false

    if available_talk_duration >= talk.duration
      add_talk_start_time(talk)
      @session_talks.push(talk)
      accepted = true
    end

    return accepted
  end

  def print
    talks = String.new
    
    @session_talks.each do |t|
      talks += "#{t.printable_start_time} #{t.subject} \n"
    end

    return talks
  end

  def is_acceptable?(talk)
    talk.duration <= @session_duration_minutes
  end

  private

  def total_talks_duration
    total_time = 0

    @session_talks.each { |talk| total_time += talk.duration }
    
    return total_time
  end

  def add_talk_start_time(talk)
    if @session_talks.empty?
      talk.start = Time.new(2014, 01, 01, @session_start_time, 00)
    else
      last_talk = @session_talks.last
      talk.start = last_talk.start + (last_talk.duration * 60)
    end
  end

  protected
  
  def available_talk_duration
    return @session_duration_minutes - total_talks_duration
  end
  
  def session_start_time
  end
end

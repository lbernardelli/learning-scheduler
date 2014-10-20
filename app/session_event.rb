class SessionEvent
  attr_reader :subject
  attr_accessor :start
  
  def initialize(session_subject)
    @subject = session_subject
  end

  def printable_start_time
    start.strftime("%I:%M")
  end
end
require_relative 'exceptions/invalid_talk_exception'
require_relative 'session_event'

class Talk < SessionEvent
  attr_reader :duration

  def initialize(talk_subject)
    @subject = String.new(talk_subject).strip
    @duration = parse_duration(String.new(talk_subject))
  end

  private
  def parse_duration(talk_subject)
    if talk_subject.include? "lightning"
      durationParsed = 5
    else

      durationParsed = talk_subject.gsub!(/\D/, "").to_i
      if durationParsed == 0
        raise InvalidTalkException, "No duration found for '#{@subject}'"
      end
    end

    return durationParsed
  end

end

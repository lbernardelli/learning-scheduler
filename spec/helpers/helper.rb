module Helper
	SHORT_TALK = "something in the sky 10min"
  FULL_MORNING_TALK = "How to be Jedi for dummies 180min"
  FULL_AFTERNOON_TALK = "How to become Yoda from the trenches 240min"
  HOUR_TALK = "Mastering light saber 60min"
  IMPOSSIBLE_TALK = "Destroying all Jedis 250min"

	def short_talk
		Talk.new(SHORT_TALK)
	end

  def full_morning_talk
    Talk.new(FULL_MORNING_TALK)
  end

  def full_afternoon_talk
    Talk.new(FULL_AFTERNOON_TALK)
  end

  def hour_talk
    Talk.new(HOUR_TALK)
  end

  def impossible_talk
    Talk.new(IMPOSSIBLE_TALK)
  end

  def first_talk(track_session)
    nth_talk(track_session, 0)
  end

  def second_talk(track_session)
    nth_talk(track_session, 1)
  end

  def third_talk(track_session)
    nth_talk(track_session, 2)
  end

  def fourth_talk(track_session)
    nth_talk(track_session, 3)
  end

  def fith_talk(track_session)
    nth_talk(track_session, 4)
  end

  def sixth_talk(track_session)
    nth_talk(track_session, 5)
  end

  def nth_talk(track_session, index)
    track_session.session_talks[index]
  end 

  def network_event(track_session)
    track_session.session_talks.last
  end

end
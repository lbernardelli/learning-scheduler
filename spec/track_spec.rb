require_relative './helpers/helper'
require_relative '../app/talk'
require_relative '../app/track'
require_relative '../app/exceptions/impossible_to_schedule_talk_exception'


describe Track, "accept_talk" do
  include Helper

  it "accept short talk" do
    talk = short_talk
    track = Track.new

    was_accepted = track.accept_talk(talk)

    expect(was_accepted).to be true
    expect(track.morning_session.session_talks.size).to be(1)
    expect(track.afternoon_session.session_talks.size).to be(0)
  end

  it "accept short talk afternoon" do
    morning_talk = full_morning_talk
    talk = short_talk
    track = Track.new

    track.accept_talk(morning_talk)
    was_accepted = track.accept_talk(talk)

    expect(was_accepted).to be true
    expect(track.morning_session.session_talks.size).to be(1)
    expect(track.afternoon_session.session_talks.size).to be(1)
  end

  it "accept impossible talk" do
    talk = impossible_talk
    track = Track.new

    expect{ track.accept_talk(talk) }.to raise_error ImpossibleToScheduleTalkException
  end
end
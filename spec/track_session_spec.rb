require_relative './helpers/helper'
require_relative '../app/track_session'
require_relative '../app/talk'
require_relative '../app/morning_session'
require_relative '../app/afternoon_session'
require_relative '../app/session_event'

describe TrackSession, "accept_talk" do
  include Helper
  
  it "accepting first morning talk" do
    talk = short_talk
    session = MorningSession.new

    was_accepted = session.accept_talk(talk)

    expect(was_accepted).to be true
    expect(session.session_talks.size).to be(1)
    expect(session.session_talks.first.printable_start_time).to eq("09:00")
    expect(session.session_talks.first).to be(talk)
  end

  it "accepting first afternoon talk" do
    talk = short_talk
    session = AfternoonSession.new

    was_accepted = session.accept_talk(talk)

    expect(was_accepted).to be true
    expect(session.session_talks.size).to be(1)
    expect(session.session_talks.first.printable_start_time).to eq("01:00")
    expect(session.session_talks.first).to be(talk)
  end

  it "accepting full morning talk" do
    full_morning = full_morning_talk
    short = short_talk
    session = MorningSession.new

    full_morning_accepted = session.accept_talk(full_morning)
    short_accepted = session.accept_talk(short)

    expect(full_morning_accepted).to be true
    expect(short_accepted).to be false
    expect(session.session_talks.size).to be(1)
    expect(session.session_talks.first.printable_start_time).to eq("09:00")
    expect(session.session_talks.first).to be(full_morning)
  end

  it "accepting full afternoon talk" do
    full_afternoon = full_afternoon_talk
    short = short_talk
    session = AfternoonSession.new

    full_afternoon_accepted = session.accept_talk(full_afternoon)
    short_accepted = session.accept_talk(short)

    expect(full_afternoon_accepted).to be true
    expect(short_accepted).to be false
    expect(session.session_talks.size).to be(1)
    expect(session.session_talks.first.printable_start_time).to eq("01:00")
    expect(session.session_talks.first).to be(full_afternoon)
  end

  it "accepting 3 hour morning talk" do
    talk1 = hour_talk
    talk2 = hour_talk
    talk3 = hour_talk 
    talk4 = hour_talk
    session = MorningSession.new

    talk1_accepted = session.accept_talk(talk1)
    talk2_accepted = session.accept_talk(talk2)
    talk3_accepted = session.accept_talk(talk3)
    talk4_accepted = session.accept_talk(talk4)

    expect(talk1_accepted).to be true
    expect(talk2_accepted).to be true
    expect(talk3_accepted).to be true
    expect(talk4_accepted).to be false

    expect(session.session_talks.size).to be(3)
    expect(session.session_talks.first.printable_start_time).to eq("09:00")
    expect(session.session_talks.last.printable_start_time).to eq("11:00")
  end
end

describe AfternoonSession, "add_network_event" do
  include Helper

  it "adding network event without talks" do
    session = AfternoonSession.new

    session.add_network_event

    expect(session.session_talks.size).to be(1)
    expect(session.session_talks.first.printable_start_time).to eq("04:00")
    expect(session.session_talks.first.subject).to eq("Network event")
  end

  it "adding network event on full talks session" do
    full_afternoon = full_afternoon_talk
    session = AfternoonSession.new

    session.accept_talk(full_afternoon)
    session.add_network_event

    expect(session.session_talks.size).to be(2)
    expect(session.session_talks.first.printable_start_time).to eq("01:00")
    expect(session.session_talks.last.printable_start_time).to eq("05:00")

    expect(session.session_talks.first).to be(full_afternoon)
    expect(session.session_talks.last.subject).to eq("Network event")
  end

  it "adding network event on 180 minutes talk session" do
    full_afternoon = full_morning_talk
    session = AfternoonSession.new

    session.accept_talk(full_afternoon)
    session.add_network_event

    expect(session.session_talks.size).to be(2)
    expect(session.session_talks.first.printable_start_time).to eq("01:00")
    expect(session.session_talks.last.printable_start_time).to eq("04:00")

    expect(session.session_talks.first).to be(full_afternoon)
    expect(session.session_talks.last.subject).to eq("Network event")
  end
end
require_relative './helpers/helper'
require_relative '../app/exceptions/invalid_file_exception'
require_relative '../app/conference'
require_relative '../app/track_session'
require_relative '../app/talk'
require_relative '../app/morning_session'
require_relative '../app/afternoon_session'
require_relative '../app/session_event'

describe Conference, "schedule" do
  include Helper

  ONE_TRACK_CONFERENCE_FILE = './spec/conference_files/one_track_conference.txt'
  INEXISTENT_FILE = './spec/conference_files/inexistent.txt'  

  it "raise exception with invalid file" do
    conf = Conference.new(INEXISTENT_FILE)

    expect{ conf.schedule }.to raise_error InvalidFileException
  end

  it "schedule 1 track conference greedly schedule" do
    conf = Conference.new(ONE_TRACK_CONFERENCE_FILE)

    conf.schedule

    morning_session = conf.tracks.first.morning_session
    afternoon_session = conf.tracks.first.afternoon_session

    # Expects only one track
    expect(conf.tracks.size).to be(1)

    total_talks = morning_session.session_talks.size + afternoon_session.session_talks.size 
    expect(total_talks).to be(9) # 9 counting Network Event

    # Assert morning talks
    expect(morning_session.session_talks.size).to be(3)
    expect(first_talk(morning_session).subject).to eq("Extreme Makeover: Rubygems Edition 120min")
    expect(first_talk(morning_session).printable_start_time).to eq("09:00")
    expect(second_talk(morning_session).subject).to eq("A Peek Inside The Ruby Toolbox 50min")
    expect(second_talk(morning_session).printable_start_time).to eq("11:00")
    expect(third_talk(morning_session).subject).to eq("Under The Influence 10min")
    expect(third_talk(morning_session).printable_start_time).to eq("11:50")

    # Assert afertnoon talks
    expect(afternoon_session.session_talks.size).to be(6)
    expect(first_talk(afternoon_session).subject).to eq("Mastering Elasticsearch With Ruby 120min")
    expect(first_talk(afternoon_session).printable_start_time).to eq("01:00")
    expect(second_talk(afternoon_session).subject).to eq("Extending Gems - Patterns and Anti-Patterns of Making Your Gem Pluggable 45min")
    expect(second_talk(afternoon_session).printable_start_time).to eq("03:00")
    expect(third_talk(afternoon_session).subject).to eq("Fault Tolerant Data: Surviving the Zombie Apocalypse 45min")
    expect(third_talk(afternoon_session).printable_start_time).to eq("03:45")
    expect(fourth_talk(afternoon_session).subject).to eq("Profiling Ruby: Finding Gains In RSpec and CRuby 15min")
    expect(fourth_talk(afternoon_session).printable_start_time).to eq("04:30")
    expect(fith_talk(afternoon_session).subject).to eq("How To Roll Your Own Ops Framework In Ruby (If You Really Have To) 15min")
    expect(fith_talk(afternoon_session).printable_start_time).to eq("04:45")
    expect(network_event(afternoon_session).subject).to eq("Network event")
    expect(network_event(afternoon_session).printable_start_time).to eq("05:00")
  end
end
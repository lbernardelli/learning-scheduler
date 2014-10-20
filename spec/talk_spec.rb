require_relative '../app/talk'
require_relative '../app/exceptions/invalid_talk_exception'

describe Talk, "initialize" do
  SUBJECT = "something in the sky 20min"
  SUBJECT_INVALID = "something in the sky"
  LIGHTNING = "The best of Perl lightning"
  
  it "returns right duration" do
    talk = Talk.new(SUBJECT)
    expect(talk.duration).to eq(20)
  end

  it "returns right subject" do
    talk = Talk.new(SUBJECT)
    expect(talk.subject).to eq(SUBJECT)
  end

  it "returns invalid talk exception" do 
    expect{ Talk.new(SUBJECT_INVALID) }.to raise_error InvalidTalkException
  end

  it "return duration 5 for lightning talk" do
    talk = Talk.new(LIGHTNING)
    expect(talk.duration).to eq(5)
  end
end
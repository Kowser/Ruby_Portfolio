require 'spec_helper'

describe Answer do
  it { should belong_to :question }
  it { should have_many :responses }

  it "returns the total number of responses" do
  answer = Answer.create(text: "Does this answer has 3 responses?")
  3.times do
    answer.responses << Response.create(answer_id: answer.id)
  end
  answer.total.should eq 3
  end
end

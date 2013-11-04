require 'spec_helper'

describe Question do
  it { should belong_to :survey }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:responses).through(:answers) }

  it 'returns the total all of the responses to its answers' do
    question = Question.create(text: 'How many total responses do I have?')
    (1..3).to_a.each do |i|
      answer = Answer.create(text: 'Answer #{i}')
      question.answers << answer
      (1..4).to_a.each do |n|
        answer.responses << Response.create(answer_id: answer.id)
      end
    end
    question.total_responses.should eq 12
  end
end
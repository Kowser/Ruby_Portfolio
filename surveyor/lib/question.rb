class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  has_many :responses, through: :answers

  def total_responses
    responses.count
  end
end

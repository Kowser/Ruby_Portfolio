class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses, dependent: :destroy

  def total
    responses.count
  end
end

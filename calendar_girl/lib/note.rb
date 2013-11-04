class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true
  validates :content, presence: true
end

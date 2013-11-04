class Employee < ActiveRecord::Base
  belongs_to :division
  has_many :projects, through: :contributions
  has_many :contributions

  def self.active
    where(active: true)
  end
end

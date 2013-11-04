class Event < ActiveRecord::Base
  has_many :notes, :as => :notable, dependent: :destroy

  def self.upcoming
    where("start_time > ?", Time.now).order("start_time")
  end

  def self.search(timespan, date)
    timespans = {day: date.next, week: date + 7, month:  date >> 1}
    where("start_time <= ? AND end_time >= ?", timespans[timespan], date)
  end
end

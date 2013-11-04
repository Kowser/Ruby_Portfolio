require 'spec_helper'

new_event = { name: 'New Years', description: 'My Event', start_time: '2013-12-31T23:59:00', end_time: '2014-01-01T00:01:00' }
new_event_before = { name: 'New Years', description: 'My Event', start_time: '2014-12-31T23:59:00', end_time: '2015-01-01T00:01:00' }
new_event_past = { name: 'New Years', description: 'My Event', start_time: '2012-12-31T23:59:00', end_time: '2013-01-01T00:01:00' }

describe Event do 

  it { should have_many(:notes).dependent(:destroy) }

  it 'returns all events subsequent to the current time' do 
    Time.stub(:now) { Time.new(2013, 2, 1) }
    event = Event.create(new_event)
    event2 = Event.create(new_event_past)
    Event.upcoming.should eq [event]
  end

  it 'return all events subsequent to the current time in ascending order' do
    event2 = Event.create(new_event_before)
    event1 = Event.create(new_event)
    Event.upcoming.should eq [event1, event2]
  end

  it 'returns all the events on a particular day' do 
    event = Event.create(new_event)
    day = Date.parse('2013-12-31')
    Event.search(:day, day).should eq [event]
  end

  it 'returns all the events on a particular day when an event is multiday' do 
    event = Event.create(name: 'New Years', description: 'My Event', start_time: '2013-12-31T23:59:00', end_time: '2014-01-01T00:01:00')
    day = Date.parse('2014-01-01')
    Event.search(:day, day).should eq [event]
  end

  it 'returns all the events within a week of a particular day' do 
    event = Event.create(new_event)
    past_event = Event.create(new_event_past)
    day = Date.parse('2013-12-28')
    Event.search(:week, day).should eq [event]
  end

  it 'returns all the events in a month of a particular day' do 
    event = Event.create(new_event)
    past_event = Event.create(new_event_past)
    event_2 = Event.create(name: 'test', start_time: "2013-11-01T00:00:00", end_time: "2013-12-18T00:00:00")
    day = Date.parse('2013-12-01')
    Event.search(:month, day).should eq [event, event_2]
  end
end

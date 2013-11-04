require 'active_record'
require 'rspec'
require 'Date'
require 'shoulda-matchers'

require 'event'
require 'task'
require 'note'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do 
    Event.all.each {|event| event.destroy}
    Task.all.each {|task| task.destroy}
    Note.all.each {|note| note.destroy}
  end
end

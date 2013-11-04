require 'rspec'
require 'pg'
require 'patron'
require 'item'
require 'copy'
require 'biblioteka'

DB = PG.connect(:dbname => 'biblioteka_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM items *;")
    DB.exec("DELETE FROM copies *;")
  end
end
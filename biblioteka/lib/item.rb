require './lib/biblioteka'

class Item < Biblioteka
  attr_reader :title, :creator, :id, :checked_out, :type

  def initialize(values)
    super(values['id'])
    @title = values['title']
    @creator = values['creator']
    @type = values['type']
    @parameters['title'] = @title
    @parameters['creator'] = @creator
    @parameters['type'] = @type
  end
end



require './lib/biblioteka'

class Patron < Biblioteka
  attr_reader :name
  def initialize(values)
    super(values['id'])
    @name = values['name']
    @parameters['name'] = @name
  end

  def my_books
    results = DB.exec("SELECT * FROM copies WHERE patron_id = #{@id};")
    results.inject([]) { |my_books, result| my_books << Copy.new(result)}
  end
end
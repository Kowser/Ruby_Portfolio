require './lib/biblioteka'

class Copy < Biblioteka
  attr_reader :checked_out, :book_id, :patron_id, :parameters

  def initialize(values)
    super(values['id'])
    @checked_out = values['checked_out'] == 't' ? true : false
    @book_id = values['book_id'].to_i
    @patron_id = values['patron_id'].to_i
    @parameters['book_id'] = @book_id
    @parameters['patron_id'] = @patron_id
    @parameters['checked_out'] = @checked_out
  end

  def borrow(patron_id)
     DB.exec("UPDATE copies SET checked_out = 't' WHERE id = #{@id};")
    DB.exec("UPDATE copies SET patron_id = #{patron_id} WHERE id = #{@id};")
    @patron_id = patron_id
    @checked_out = true
    @parameters['checked_out'] = @checked_out
    @parameters['patron_id'] = @patron_id
  end

  def return
    DB.exec("UPDATE copies SET checked_out = 'f' WHERE id = #{@id};")
    DB.exec("UPDATE copies SET patron_id = 0 WHERE id = #{@id};")
    @patron_id = 0
    @checked_out = false
    @parameters['checked_out'] = @checked_out
    @parameters['patron_id'] = @patron_id
  end
end

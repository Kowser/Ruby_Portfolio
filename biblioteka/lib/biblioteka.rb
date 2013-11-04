class Biblioteka
  attr_reader :parameters, :id

  def initialize(id=nil)
    @id = id.to_i
    @parameters = {'id' => @id}
  end

  def self.all(table_name)
    results = DB.exec("SELECT * FROM #{table_name};")
    results.inject([]) { |array, result| array << self.new(result)}
  end

  def ==(other)
    self.class == other.class &&
    self.parameters == other.parameters
  end

  def save(table_name)
    @parameters.delete('id')
    query = "INSERT INTO #{table_name} ("
    @parameters.each do |key, value|
      query += key + ", "
    end
    query.slice!(-2,2)
    query += ") VALUES ("
    @parameters.each do |key, value|
      query += "'#{value}', "
    end
    query.slice!(-2,2)
    query += ") RETURNING id;"
    results = DB.exec(query)
    @id = results.first['id'].to_i
    @parameters['id'] = @id
  end
end



require 'pg'

class Task
  def initialize(name, list_id, id=nil)
    @id = id
    @name = name
    @list_id = list_id
    @done = false
  end

  attr_reader :name, :list_id, :id, :due_date, :done

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      id = result['id']
      name = result['name']
      list_id = result['list_id'].to_i
      tasks << Task.new(name, list_id, id)
    end
    tasks
  end

  def set_due_date(date)
    @due_date = date
  end

  def set_done
    @done = !@done
  end

  def save
    results = DB.exec("INSERT INTO tasks (name, list_id, due_date, done) VALUES ('#{@name}', #{@list_id}, '#{@due_date}', #{done}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end
end

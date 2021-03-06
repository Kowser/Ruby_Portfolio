require 'spec_helper'

describe Task do
  it' is initialized with a name and a task ID' do
    task = Task.new('learn SQL', 1)
    task.should be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL', 1)
    task.name.should eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new('learn SQL', 1)
    task.list_id.should eq 1
  end

  it 'tells you its table ID' do
    task = Task.new('learn SQL', 1)
    task.save
    task.id.should be_an_instance_of Fixnum
  end

  it 'starts off with no tasks' do
    Task.all.should eq []
  end

  it 'lets you add a due date' do
    task = Task.new('learn SQL', 1)
    task.set_due_date('1/1/2014')
    task.due_date.should eq('1/1/2014')
  end

  it 'let you toggle whether the task is done or not' do
    task = Task.new('learn SQL', 1)
    task.set_done
    task.done.should eq true
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL', 1)
    task.save
    Task.all.should eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new('Learn SQL', 1)
    task2 = Task.new('Learn SQL', 1)
    task1.should eq task2
  end  
end

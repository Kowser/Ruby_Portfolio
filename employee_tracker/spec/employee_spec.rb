require 'spec_helper'

describe Employee do
  it { should belong_to :division }
  it { should have_many(:projects).through(:contributions) }

    it 'initializes as an instance of Employee' do
    employees = Employee.create({})
    employees.should be_an_instance_of Employee
  end

  it 'can return only active employees' do
    employees = (1..5).to_a.map {|number| Employee.create(name: "Employee #{number}", hire_date: "2013/9/17", active: true)}
    resigned_employee = Employee.create(name: "Resignee", hire_date: "2013/9/17", resign_date: "2013/10/31", active: false)
    Employee.active.should eq employees
  end
end
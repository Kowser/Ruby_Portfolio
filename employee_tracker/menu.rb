require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def company_menu
  puts `clear`
  puts "Company Main Menu"
  puts
  puts '(E)mployee Menu'
  puts '(D)ivision Menu'
  puts '(P)rojects Menu'
  puts 'e(X)it'
  puts
  choice = gets.chomp.downcase
  case choice
  when 'e'
    employee_menu
  when 'd'
    division_menu
  when 'p'
    project_menu
  when 'x'
    puts 'Good-bye!'
  else
    puts 'Invalid Option.'
  end
end

#---------EMPLOYEES--------------
def employee_menu
  puts "Employee  Menu"
  puts
  puts '(A)dd Employee'
  puts '(R)esign Employee'
  puts '(U)pdate Employee'
  puts '(L)ist Employees'
  puts '(P)roject by Employee'
  puts
  puts '(M)ain Menu'
  puts 'e(X)it'
  puts
  choice = gets.chomp.downcase
  case choice
  when 'a'
    employee_add
  when 'r'
    employee_resign
  when 'u'
    # employee_update
  when 'l'
    employee_list
  when 'p'
    employee_projects
  when 'm'
    company_menu
  when 'x'
    puts 'Good-bye!'
  else
    puts 'Invalid Option.'
    employee_menu
  end
end

def employee_add
  puts 'Add Employee'
  puts
  puts 'Name'
  name = gets.chomp
  puts
  puts 'Hire Date (yyyy/mm/dd)'
  hire_date = gets.chomp
  puts
  puts 'Division ID'
  division_id = gets.chomp
  Employee.create(name: name, hire_date: hire_date, active: true, division_id: division_id)
  puts "#{name} added successfully"
  employee_menu
end

def employee_resign
  puts 'Employee Resignation'
  puts
  puts 'Enter employee ID'
  id = gets.chomp.to_i
  puts
  puts 'Enter resignation date (yyyy/mm/dd)'
  resign_date = gets.chomp
  update_employee = Employee.where(id: id).first
  update_employee.update_attributes(resign_date: resign_date, active: false)
  puts
  puts "#{update_employee.name} resigned on #{resign_date}. Update complete."
  employee_menu
end

def employee_list
  puts 'Employee Listing'.center(85)
  puts
  puts 'ID | '.center(5) + 'Name | '.center(30) + 'Hire Date | '.ljust(15) + 'Resign Date | '.ljust(15) + 'Active'.ljust(10) + 'Div'.center(5)
  puts "-" * 85
  Employee.all.each do |employee|
    puts "#{employee.id}".center(5) + "#{employee.name}".ljust(30) +  "#{employee.hire_date}".ljust(15) + "#{employee.resign_date}".ljust(15) + "#{employee.active}".ljust(15) + "#{employee.division_id}".center(5)
  end
  puts
  employee_menu
end

def employee_projects
  puts `clear`
  puts
  puts 'Projects by Employee'
  puts
  Employee.all.each do |employee|
    puts "#{employee.name}".center(40)
    puts "-"*40
    employee.projects.each { |project| puts "#{project.id} | #{project.name}"}
    puts
  end
  employee_menu
end

#---------DIVISIONS--------------
def division_menu
  puts "Division  Menu"
  puts
  puts '(C)reate Division'
  puts '(I)nactivate Division'
  puts '(U)pdate Division'
  puts '(L)ist Divisions'
  puts '(E)mployees by Division'
  puts
  puts '(M)ain Menu'
  puts 'e(X)it'
  puts
  choice = gets.chomp.downcase
  case choice
  when 'c'
    division_create
  when 'a'
    division_add_employee
  when 'i'
    # division_inactivate
  when 'u'
    # division_update
  when 'l'
    division_list
  when 'e'
    division_employee_list
  when 'm'
    company_menu
  when 'x'
    puts 'Good-bye!'
  else
    puts 'Invalid Option.'
    division_menu
  end
end

def division_create
  puts 'Add division'
  puts
  puts 'Name'
  name = gets.chomp
  Division.create(name: name)
  puts "#{name} added successfully"
  division_menu
end

def division_add_employee
  puts 'Add Employee to Division'
  puts
  puts 'Division ID'
  division_id = gets.chomp.to_i
  puts
  puts 'Employee ID'
  employee_id = gets.chomp.to_i
  division = Division.find(division_id)
  employee = Employee.find(employee_id)
  division.employees << Employee.find(employee_id)
  puts employee.name + ' added to division' + division.name
  puts
  division_menu
end

def division_list
  puts 'Division Listing'.center(80)
  puts
  puts 'ID | '.center(10) + 'Name | '.center(30)
  puts "-" * 80
  Division.all.each do |division|
    puts "#{division.id}".center(10) + "#{division.name}".ljust(30)
  end
  puts
  division_menu
end

def division_employee_list
  puts
  puts 'Employees by Division'
  puts
  Division.all.each do |division|
    puts "#{division.name}".center(40)
    puts "-"*40
    division.employees.each { |employee| puts "#{employee.id}".center(5) + " | " + "#{employee.name}".ljust(32) }
    puts
  end
  puts
  division_menu
end

#---------PROJECTS--------------
def project_menu
  puts "Project  Menu"
  puts
  puts '(C)reate Project'
  puts '(A)dd employee to Project'
  puts '(I)nactivate Project'
  puts '(U)pdate Project (rename)'
  puts '(L)ist Projects'
  puts '(E)mployees by Project'
  puts
  puts '(M)ain Menu'
  puts 'e(X)it'
  puts
  choice = gets.chomp.downcase
  case choice
  when 'c'
    project_create
  when 'a'
    project_add_employee
  when 'i'
    # project_inactivate
  when 'u'
    project_rename
  when 'l'
    project_list
  when 'e'
    project_employee_list
  when 'm'
    company_menu
  when 'x'
    puts 'Good-bye!'
  else
    puts 'Invalid Option.'
    project_menu
  end
end

def project_create
  puts 'Add Project'
  puts
  puts 'Name'
  name = gets.chomp
  Project.create(name: name)
  puts "#{name} added successfully"
  project_menu
end

def project_add_employee
  puts 'Add Employee to Project'
  puts
  puts 'Project ID'
  project_id = gets.chomp.to_i
  puts
  puts 'Employee ID'
  employee_id = gets.chomp.to_i
  project = Project.find(project_id)
  employee = Employee.find(employee_id)
  project.employees << Employee.find(employee_id)
  puts employee.name + ' added to project' + project.name
  puts
  project_menu
end

def project_rename
  puts
  puts 'Which Project ID?'
  id = gets.chomp.to_i
  project = Project.find(id)
  puts
  puts 'New Name'
  name = gets.chomp
  project.update_attributes(name: name)
  project_menu
end

def project_list
  puts 'Project Listing'.center(80)
  puts
  puts 'ID'.center(5) + ' | ' + 'Name'.center(32)
  puts "-" * 80
  Project.all.each do |project|
    puts "#{project.id}".center(5) + ' | ' + "#{project.name}".ljust(32)
  end
  puts
  project_menu
end

def project_employee_list
  puts
  puts 'Employees by Project'
  puts
  Project.all.each do |project|
    puts "#{project.name}".center(40)
    puts "-"*40
    project.employees.each { |employee| puts "#{employee.id}".center(5) + " | " + "#{employee.name}".ljust(32) }
    puts
  end
  puts
  project_menu
end

#-----------------------
company_menu

class UpdateEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :hire_date, :date
    add_column :employees, :resign_date, :date
    add_column :employees, :division_id, :integer
  end
end

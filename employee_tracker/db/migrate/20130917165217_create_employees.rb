class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.column :name, :string
      t.column :active, :boolean

      t.timestamps
    end
  end
end
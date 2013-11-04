class EventsAddcolumnName < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
  end
end

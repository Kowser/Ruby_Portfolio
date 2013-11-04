class CreateAnswersResponses < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text
      t.integer :question_id

      t.timestamps
    end
    
    create_table :responses do |t|
      t.integer :answer_id

      t.timestamps
    end
  end
end

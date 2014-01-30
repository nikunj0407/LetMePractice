class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :cipher
      t.string :type
      t.integer :chapter_id
      t.attachment :img
      t.integer :weightage

      t.timestamps
    end
  end
end

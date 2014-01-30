class CreateTestDetails < ActiveRecord::Migration
  def change
    create_table :test_details do |t|
      t.integer :test_result_id, null: false
      t.integer :question_id, null: false
      t.string :question_type
      t.text :answer, null: false, default: ''
      t.integer :score, null: false, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end

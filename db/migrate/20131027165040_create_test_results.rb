class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :user_id, null: false
      t.integer :obj_score, default: 0
      t.string :test_time

      t.timestamps
    end
  end
end

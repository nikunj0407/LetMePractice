class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.text :key
      t.integer :val
      t.integer :question_id

      t.timestamps
    end
  end
end

class ProgressReportUsers < ActiveRecord::Migration
  def up
    create_table :progress_report_users, {:id => false, :force => true}  do |t|
      t.integer :user_id
      t.integer :test_result_id
      t.string :fill
      t.integer :fill_score
      t.string :tf
      t.integer :tf_score
      t.string :mcq1
      t.integer :mcq1_score
      t.string :mcq2
      t.integer :mcq2_score
      t.string :mcq3
      t.integer :mcq3_score
      t.string :rearrange
      t.integer :rearrange_score
    end
  end

  def down
  end
end
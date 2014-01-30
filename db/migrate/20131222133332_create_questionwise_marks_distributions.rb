class CreateQuestionwiseMarksDistributions < ActiveRecord::Migration
  def change
    create_table :questionwise_marks_distributions do |t|
      t.string :question_type
      t.integer :weightage
      t.timestamps
    end
  end
end

class TestDetail < ActiveRecord::Base
  attr_accessible :answer, :question_id, :score, :test_result_id, :user_id, :question_type

  belongs_to :user
  belongs_to :test_result
  belongs_to :question
end

class ProgressReportUser < ActiveRecord::Base
  attr_accessible :user_id, :test_result_id, :fill, :fill_score, :tf, :tf_score, :mcq1, :mcq1_score, :mcq2, :mcq2_score, :mcq3, :mcq3_score, :rearrange,:rearrange_score

  belongs_to :user
  belongs_to :test_result
end
class TestResult < ActiveRecord::Base
  attr_accessible :obj_score, :user_id, :test_time

  belongs_to :user
  has_many :test_details, dependent: :destroy
end

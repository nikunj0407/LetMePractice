class Option < ActiveRecord::Base
  attr_accessible :key, :question_id, :val

  belongs_to :question
end

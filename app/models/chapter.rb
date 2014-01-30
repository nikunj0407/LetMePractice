class Chapter < ActiveRecord::Base
  attr_accessible :name, :weightage
  has_many :questions
end

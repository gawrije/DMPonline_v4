class Answer < ActiveRecord::Base
  
	#associations between tables
	belongs_to :question
	belongs_to :user
	belongs_to :plan
	has_and_belongs_to_many :options
	attr_accessible :text, :plan_id, :question_id, :user_id, :option_ids
	accepts_nested_attributes_for :question
	accepts_nested_attributes_for :plan
	
end

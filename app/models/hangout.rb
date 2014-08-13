class Hangout < ActiveRecord::Base
	belongs_to :user
	belongs_to :decisionmaker
	has_and_belongs_to_many :initiatives
end

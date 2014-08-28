class Hangout < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :initiatives
	has_and_belongs_to_many :decisionmakers
end

class Result < ActiveRecord::Base
	has_and_belongs_to_many :initiatives
	has_and_belongs_to_many :decisionmakers
	validates :decision,
			presence: true
end

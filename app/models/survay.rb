class Survay < ActiveRecord::Base
	belongs_to :initiative
	has_many :feedbacks
end

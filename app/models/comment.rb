class Comment < ActiveRecord::Base
	belongs_to :initiative 
	validates :content,
		presence: true
end

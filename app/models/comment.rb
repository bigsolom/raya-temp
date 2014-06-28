class Comment < ActiveRecord::Base
	belongs_to :initiative 
	belongs_to :user
	validates :content,
		presence: true
end

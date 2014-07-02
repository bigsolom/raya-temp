class Poll < ActiveRecord::Base
	has_many :questions, :dependent => :destroy
	belongs_to :initiative
	
	accepts_nested_attributes_for :questions, :reject_if => lambda { |x| x[:content].blank? }, :allow_destroy => true
end

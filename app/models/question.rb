class Question < ActiveRecord::Base
	belongs_to :poll
	has_many :answers, :dependent => :destroy
	accepts_nested_attributes_for :answers, :reject_if => lambda { |x| x[:content].blank? }, :allow_destroy => true
end

class Question < ActiveRecord::Base
	belongs_to :poll
	has_many :answers, :dependent => :destroy
	accepts_nested_attributes_for :answers, :reject_if => lambda { |x| x[:content].blank? }, :allow_destroy => true

  has_and_belongs_to_many :users #initiative

end

class Feedback < ActiveRecord::Base
  has_and_belongs_to_many :users #initiative
  belongs_to :survay
end

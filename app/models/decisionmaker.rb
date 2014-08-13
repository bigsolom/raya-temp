class Decisionmaker < ActiveRecord::Base
has_and_belongs_to_many :results
has_many :hangouts

end

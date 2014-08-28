class Decisionmaker < ActiveRecord::Base
has_and_belongs_to_many :results
has_and_belongs_to_many :decisionmakers
end

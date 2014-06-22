class Region < ActiveRecord::Base
  has_many :initiatives

  scope :regionSearch, lambda{|regionSearch| where (["name LIKE ?","%#{regionSearch}%"])}

end

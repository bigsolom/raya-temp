class Sector < ActiveRecord::Base
	has_many :initiatives 

 scope :sectorSearch, lambda{|sectorSearch| where (["name LIKE ?","%#{sectorSearch}%"])}

end

class Initiative < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  has_and_belongs_to_many :tags
  belongs_to :sector
  has_many :commetns

  has_and_belongs_to_many :users
  #has_and_belongs_to_many :updates
  #has_and_belongs_to_many :results
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  has_and_belongs_to_many :results


  #search scope by title & Region of initiative
  scope :searchRegion, lambda{|searchRegion| where (["region_id LIKE ?","%#{searchRegion}%"])}
  scope :searchTitle, lambda{|searchTitle| where (["title LIKE ?","%#{searchTitle}%"])}
  scope :searchSector, lambda{|searchSector| where (["sector_id LIKE ?","%#{searchSector}%"])}

end

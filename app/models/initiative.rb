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


  #search by
  scope :searchTitle, lambda{|searchTitle| where (["title LIKE ?","%#{searchTitle}%"])}
  

  def self.searchSector(sector_name)
      if Sector.find_by_name(sector_name)
        Sector.find_by_name(sector_name).initiatives
      end
  end

   def self.searchUser(user_id)
      if User.find_by_id(user_id)
        User.find_by_id(user_id).initiatives
      end
  end

  def self.searchRegion(region_name)
      if Region.find_by_name(region_name)
        Region.find_by_name(region_name).initiatives
      end
  end

  def self.tagged_with(tag_name)
      if Tag.find_by_name(tag_name)
       Tag.find_by_name(tag_name).initiatives
      end
  end

  def self.searchAll(search_all)
      Initiative.searchSector(search_all) or Initiative.searchRegion(search_all) or Initiative.searchTitle(search_all)         
  end


end

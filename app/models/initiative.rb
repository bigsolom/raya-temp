  require 'state_machine'

class Initiative < ActiveRecord::Base
   
  

  state_machine :initial => :new do
    event :in_progress do
      transition :new => :in_progress
    end  
    event :expired do
      transition :new => :expired
    end  
    event :closed do
      transition :in_progress => :closed
    end  
  

  

  end
    
 
  belongs_to :user
  belongs_to :region
  has_and_belongs_to_many :tags
  belongs_to :sector
  has_many :commetns
  has_many :polls
  has_many :survays
  has_and_belongs_to_many :hangouts


  
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
      if User.find(user_id)
        User.find(user_id).initiatives
      end
  end

    def self.searchFriend(friends_ids)
      if User.find(friends_ids)
        User.find(friends_ids).followed_users
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

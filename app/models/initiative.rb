class Initiative < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  has_and_belongs_to_many :tags
  belongs_to :sector
  has_many :commetns
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
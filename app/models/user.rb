class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
  has_many :initiatives
  has_and_belongs_to_many :initiatives

  has_and_belongs_to_many :answers #initiative
  has_and_belongs_to_many :questions #initiative
 
  has_many :comments

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/default_profile.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

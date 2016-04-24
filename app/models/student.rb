class Student < ActiveRecord::Base
  has_many :songs, through: :student_songs
  has_many :student_songs
  has_secure_password
  validates_presence_of :username, :password
 
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|a| a.slug == slug }
  end
end
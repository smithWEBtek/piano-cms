class Song < ActiveRecord::Base
  has_many :students, through: :student_songs
  has_many :student_songs
  validates_presence_of :name
 
  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|a| a.slug == slug }
  end

  def delete_song(id)
    song = Song.find(id)
    song.delete
  end
end
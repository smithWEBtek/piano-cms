class StudentSong < ActiveRecord::Base
  belongs_to :student 
  belongs_to :song

end
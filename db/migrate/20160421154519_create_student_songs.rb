class CreateStudentSongs < ActiveRecord::Migration
  def change
    create_table :student_songs do |ss|
      ss.integer :student_id
      ss.integer :song_id
    end
  end
end

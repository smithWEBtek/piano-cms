class SongsController < ApplicationController

  get '/songs' do
    if current_user
      @songs = Song.all
      erb :'/songs/index.html'
    else
      redirect to '/'
    end
  end

  get '/songs/:slug' do
    if current_user
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/show.html'
    else
      redirect to '/'
    end
  end

  get '/songs/:id/edit' do
    if current_user
      erb :'/songs/edit.html'
    else
      erb :'/'
    end
  end 
 
  def student_song_ids(id)
    @ss_ids = []
    StudentSong.all.each do |row|
      if row.student_id == @student.id
        @ss_ids.push(row.song_id)
      end
      @ss_ids
    end
  end

  def add_student_song(name)
    song = Song.create(name)
    @student.songs.push(song)
  end
 
  patch '/songs/:id' do 
    if current_user
      student_song_ids(@student.id)
      if params["student"]["song_ids"]
        params["student"]["song_ids"].each do |id|
          if !@ss_ids.include?(id.to_i)
            StudentSong.create(song_id: id.to_i, student_id: @student.id)
          end
        end
      end
      
      @ss_ids.each do |id|
        if !params["student"]["song_ids"].include?(id.to_s)
           @student_song= StudentSong.find_by(song_id: id, student_id: @student.id)
           @student_song.delete
        end
      end

      if !params["student"]["new_song"].empty?
        add_student_song(name: params["student"]["new_song"])
      end
      redirect to :"/students/#{@student.id}"
    end     
  end
end
class SongsController < ApplicationController

  get '/songs/new' do
    if logged_in?
      current_user
    erb :'/songs/new'
    end
  end

  get '/songs' do
    if logged_in?
      current_user
      @songs = Song.all
      erb :'/songs/index'
    else
      redirect to '/'
    end
  end

  post '/songs' do
    if logged_in?
      current_user
      @student_songs = params["student"]["song_ids"] 
    @student_songs.each do |sid|
      if !StudentSong.find_by(song_id: sid)
        StudentSong.create(song_id: sid, student_id: @student.id)
      end
    if !params["song"]["name"].empty? && !Song.find_by(name: params["song"]["name"])
      @song = Song.create(name: params["song"]["name"])
      StudentSong.create(song_id: @song.id, student_id: @student.id)
      end
      redirect to "students/#{@student.slug}"
      end
    end
  end 
 
  get '/songs/:slug' do
    if logged_in?
      current_user
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/show'
    else
      redirect to '/'
    end
  end

  get '/songs/:id/edit' do
    if logged_in?
      current_user
    end
    erb :'/songs/edit'
  end 

end
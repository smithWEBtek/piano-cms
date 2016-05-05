class SongsController < ApplicationController

  get '/songs' do
    if logged_in?
      current_user
      @all_songs = Song.all
      erb :'/songs/index.html'
    else
      redirect to '/'
    end
  end

  get '/songs/:id' do
    if logged_in? 
      current_user
      @song = Song.find(params[:id])
      erb :'/songs/show.html'
    else
      redirect to '/'
    end
  end

  get '/songs/:id/edit' do
    if logged_in? 
      current_user
      @all_songs = Song.all.order(:name)
      erb :'/songs/edit.html'
    else
      redirect to '/'
    end
  end 
  
  post '/songs/new' do
    if params["song"]["name"].present?
      new_song = Song.create(name: params["song"]["name"])
      current_user.songs.push(new_song)
      redirect to :"/students/#{current_user.id}"
    end
  end

  patch '/songs/:id' do 
    current_user.songs.clear
    if !params.include?("student") == true
      redirect to :"/students/#{current_user.id}" 
    else
      params["student"]["song_ids"].each do |id|
        song = Song.find(id)
        current_user.songs.push(song)
      end
    end
    redirect to :"/students/#{current_user.id}"  
  end

  patch '/songs/:id/delete' do
    if current_user && current_user.username == "admin"
      params["song"]["song_ids"].each do |song_id|
        song = Song.find(song_id)
        song.delete
      end
    end
    redirect to '/admin' 
  end
end
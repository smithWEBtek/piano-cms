class StudentsController < ApplicationController
   
  get '/' do
    if logged_in?
      current_user
    erb :'/index'
  else
    erb :'/index'
    end
  end

  get '/signup' do
    if logged_in?
      current_user
      redirect to "/students/#{@student.username}", locals: {message: "You are already signed in."}
    else
      erb :'/students/new'
    end
  end

  post '/signup' do
    if Student.find_by(username: params[:username])
      erb  :'/students/new', locals: {message: "Username is taken, please try a different Username."}
    else
      @student = Student.new(username: params[:username], password: params[:password])
    if  @student.save
      session[:student_id] = @student.id
      redirect to "/students/#{@student.username}"
    else
      redirect to '/signup'
      end
    end
  end

  get '/login' do
    if logged_in?
      current_user
      redirect to "/students/#{@student.username}"
    else
      erb :'/students/login'
    end
  end

  post '/login' do
    @student = Student.find_by(username: params[:username])
    if @student && @student.authenticate(params[:password])
      session[:student_id] = @student.id
      redirect to "/students/#{@student.username}"
    else
      erb :'/students/login'
    end
  end

  get '/logout' do
    session.clear
    erb :'/students/logout'
  end

  get '/students' do
    if logged_in?
      current_user
      @students = Student.all
      erb :'/students/index'
    else
      redirect to '/'
    end
  end

  get '/students/:slug' do
    @student = Student.find_by_slug(params[:slug]) 
    erb :'/students/show', locals: {message: "#{@student.username}, here are the songs you are working on: "}
  end

  get '/students/:slug/edit' do
    if logged_in?
      @student = Student.find_by_slug(params[:slug]) 
      erb :"/students/#{@student.slug}"
    else
      logout
      redirect to '/'
    end
  end

  patch '/students/:id/songs' do 
    if logged_in?
    current_user
 
    if !params["student"]["new_song"].empty?
      song = Song.create(name: params["student"]["new_song"])
      @student.songs << song
    end
     
    @ids = params["student"]["song_ids"]
    
    ct = 0
    while ct < @ids.size do
      @ids.each do |i|
      @song = Song.find(i)
      if !@student.songs.include?(@song)
        @student.songs.push(@song)
      ct += 1
      end
    end
 
    StudentSong.all.each do |row|
      if row.student_id == @student.id
        row.delete if !@ids.find(song_id: row.song_id)
        end
      end
    redirect to "/students/#{@student.username}"
      end
    end
  end  

end









class ApplicationController < Sinatra::Base
<<<<<<< HEAD

   configure do
=======
 
  configure do
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

<<<<<<< HEAD
  patch '/admin' do 
    if current_user && @student.username == "admin"
      if params["student"]["student_ids"]
        params["student"]["student_ids"].each do |student_id|
        delete_student(student_id)
        end
      end
      if params["student"]["new_student"]
        Student.create(username: params["student"]["new_student"], password: "asdf")
      end
    end
    redirect to '/admin/index.html'
  end        

  patch '/admin/songs' do
    if current_user && @student.username == "admin"
      if params["song"]["song_ids"]
        params["song"]["song_ids"].each do |song_id|
        delete_song(song_id)
        end
      end 
      if params["song"]["new_song"]
        Song.create(name: params["song"]["new_song"])
      end
    end
    redirect to '/'       
  end     
 
  helpers
=======
  get '/' do
    erb :'/admin/index.html'
  end

  get '/login' do
    if logged_in?
      redirect to "/students/#{current_user.id}"
    else
      erb :'/admin/login.html'
    end
  end

  post '/login' do
    if login(params)
      redirect to "/students/#{current_user.id}"
    else
      erb :'/admin/login.html', locals: {message: "Failed login, try again."}
    end
  end
  
  get '/logout' do
    if logged_in?
      @user_logout_name = current_user.username
      logout
      erb :'/admin/logout.html'
    elsif !user_logout_name
      redirect to '/'
    else
    end
  end

  get '/admin' do
    erb :'/admin/index.html'
  end

  get '/admin/welcome' do
    @student = Student.all.last
    erb :'/admin/success.html'
  end
 
  helpers do
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    def logged_in?
      !!session[:student_id]
    end

    def current_user
      @current_user = Student.find(session[:student_id])
    end
<<<<<<< HEAD

    def login(id)
      session[:student_id] = id
=======
 
    def login(params)
      if student = Student.find_by(username: params[:username])
        if student.authenticate(params[:password])    
          session[:student_id] = student.id
          redirect to :"/students/#{current_user.id}"
        end         
      else
        redirect to '/'
      end
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    end

    def logout
      session.clear
    end
 
    def delete_student(id)
      student = Student.find(id)
      student.delete
    end

    def delete_song(id)
      song = Song.find(id.to_i)
      song.delete
    end 
  end
end 
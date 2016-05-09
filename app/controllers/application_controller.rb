class ApplicationController < Sinatra::Base
 
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

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
    @all_students = Student.all.order(:username)
    erb :'/admin/index.html'
  end

  get '/admin/welcome' do
    @student = Student.all.last
    erb :'/admin/success.html'
  end
 
  helpers do
    def logged_in?
      !!session[:student_id]
    end

    def current_user
      @current_user = Student.find(session[:student_id])
    end
 
    def login(params)
      if student = Student.find_by(username: params[:username])
        if student.authenticate(params[:password])    
          session[:student_id] = student.id
          redirect to :"/students/#{current_user.id}"
        end         
      else
        redirect to '/'
      end
    end

    def logout
      session.clear
    end
  end
end 
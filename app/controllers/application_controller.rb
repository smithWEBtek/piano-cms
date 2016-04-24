class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      current_user
    erb :'/index'
  else
    erb :'/index'
    end
  end 

  helpers
    def logged_in?
      !!session[:student_id]
    end

    def current_user
      if logged_in?
        @student = Student.find(session[:student_id])
    end

    def login(student_id)
      session[:student_id] = student_id
    end

    def logout
      session.clear
    end
  end
end 
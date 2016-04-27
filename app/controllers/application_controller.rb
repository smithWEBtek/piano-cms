class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/admin' do
    if logged_in? 
      current_user
      if @student.username == "admin"
        erb :'/admin_edit.html'
      else
        erb :'/index.html' 
      end
    end
  end

  patch '/admin' do
    if logged_in? 
      current_user
      if @student.username == "admin"
        @ids = params["student"]["student_ids"]
      Student.all.each do |student|
        if !@ids.include?(student.id.to_s)
          student.delete unless student.username == "admin"
        end
      end
      if !params["student"]["new_student"].empty?
        Student.create(username: params["student"]["new_student"], password: "asdf")
      end
      @ids = params["song"]["song_ids"]
        Song.all.each do |song|
        if !@ids.include?(song.id.to_s)
          song.delete
        end
      end
      if !params["song"]["new_song"].empty?
        Song.create(name: params["song"]["new_song"])
      end
        erb :"/admin_edit.html"        
      end
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
class ApplicationController < Sinatra::Base

   configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

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
    def logged_in?
      !!session[:student_id]
    end

		def current_user
      @current_user = Student.find(session[:student_id])
    end

    def login(id)
      session[:student_id] = id
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
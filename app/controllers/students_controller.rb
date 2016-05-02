class StudentsController < ApplicationController
   
  get '/' do
    current_user
    erb :'/index.html'  
  end

  get '/signup' do
    if logged_in?
      current_user
      redirect to "/students/#{@student.id}"
    else
      erb :'/students/new.html'
    end
  end

  post '/signup' do 
    if Student.find_by(username: params[:username])
      erb :'/students/new.html', locals: {message: "Username is taken, please try a different Username."}
    else
      @student = Student.new(params)
      if @student.save
        session[:student_id] = @student.id 
### use helper login method?  (see below)
        redirect to "/students/#{@student.id}"
      else
        redirect to '/signup'
      end
    end
  end

  get '/login' do
    if logged_in?
      current_user
      redirect to "/students/#{@student.id}"
    else
      erb :'/students/login.html'
    end
  end

  post '/login' do
    @student = Student.find_by(username: params[:username])
    if @student && @student.authenticate(params[:password])
      # session[:student_id] = @student.id
login(@student.id)  ####### see below ##### refactor ? ### login method? 
      redirect to "/students/#{@student.id}"
    else
      redirect to '/login'
# You might want to add a flash message here - google it!
# I found it, installed Flash Gem, but was not able to get it to work yet
    end
  end
#########################################################################
#   why does this login method work when it is in students_controller, 
#   but it doesn't work if only in the application_controller helpers?  
    
    # def login(student_id)
    #   session[:student_id] = student_id
    # end

#     NoMethodError at /login
#     undefined method `login' for #<StudentsController:0x007fed4b9970b0>
#########################################################################

  get '/logout' do
    if current_user
      logout
      erb :'/index.html',locals:{message: "Successful Log Out. Keep practicing, #{@student.username.upcase}!"}
    elsif !current_user
      redirect to '/index.html'
    else
    end
  end

  get '/students' do
    if current_user
      @students = Student.all
      erb :'/students/index.html'
    else
      redirect to '/'
    end
  end

  get '/students/:id' do
    if logged_in?
      @student = Student.find(params[:id])
      erb :'/students/show.html', locals: {message: "Current song list for #{@student.username.upcase}: "}
    else
      redirect to '/'
    end
  end

 get '/students/:slug' do
    if current_user
      @student_list = Student.find_by_slug(:slug)
      erb :'/students/show.html', locals: {message: "Current song list for #{@student_list.slug.upcase}: "}
    else
      redirect to '/'
    end
  end

  get '/students/:id/edit' do
    if current_user
      erb :'/students/edit.html'
    else
      redirect to '/'
    end
  end

  patch '/students/:id/edit' do
    if current_user
    @student.update(params["student"]) 
      if !@student.save  
        erb :'/students/edit.html', locals: {message: "Edit failed, please enter a valid Username and Password."}
      else
        redirect to "/students/#{@student.id}"
      end
    end
  end
end
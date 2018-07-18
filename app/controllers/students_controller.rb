class StudentsController < ApplicationController
   
<<<<<<< HEAD
  get '/' do
    current_user
    erb :'/index.html'  
  end

  get '/signup' do
    if logged_in?
      current_user
      redirect to "/students/#{@student.id}"
=======
  get '/students' do
    if logged_in?
      current_user
      @all_students = Student.all
      erb :'/students/index.html'
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    else
      redirect to '/'
    end
  end

<<<<<<< HEAD
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
      session[:student_id] = @student.id
### login(@student.id)  ####### see below ##### refactor ? ### login method? 
      redirect to "/students/#{@student.id}"
    else
      redirect to '/login'
### You might want to add a flash message here - google it!
### I found it, installed the Gem, but was not able to get it to work yet
=======
  get '/students/new' do
    erb :'/students/new.html'
  end

  get '/students/destroy' do
    @all_students = Student.all.order(:username)
    erb :'/students/delete.html'
  end

  post '/students/new' do
    if Student.find_by(username: params[:username])
      redirect to '/students/new'
    else
      Student.create(params)
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    end
    redirect to :'admin/welcome'
  end
################################################################
### why does this login method work when it is in students_controller, 
### but it doesn't work if only in the application_controller helpers?  

    # def login(student_id)
    #   session[:student_id] = student_id
    # end
################################################################

<<<<<<< HEAD
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
=======
  get '/students/:id' do
    if logged_in?
      current_user
      if current_user.id == params[:id]
        @student = current_user
      else
        @student = Student.find(params[:id])
      end
      erb :'/students/show.html'
    end
  end
 
  get '/students/:id/edit' do
    if logged_in?
      current_user
      erb :'/students/edit.html'
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    else
      redirect to '/students'
    end
  end

<<<<<<< HEAD
  get '/students/:id/edit' do
    if current_user
      erb :'/students/edit.html'
=======
  patch '/students/:id' do 
    if current_user.update(params["student"])
      redirect :"/students/#{current_user.id}"
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
    else
      redirect to :"/students/#{current_user.id}/edit"
    end
  end

<<<<<<< HEAD
  patch '/students/:id/edit' do
    if current_user
    @student.update(params["student"]) 
      if !@student.save  
        erb :'/students/edit.html', locals: {message: "Edit failed, please enter a valid Username and Password."}
      else
        redirect to "/students/#{@student.id}"
=======
  patch '/students/:id/delete' do
    if logged_in? && current_user.username == "admin"
      params["student"]["student_ids"].each do |student_id|
        student = Student.find(student_id)
        student.delete
>>>>>>> 14175612567dbd181af3bbf9e201aa3f41921d0c
      end
    end
    redirect to '/admin'
  end 
end
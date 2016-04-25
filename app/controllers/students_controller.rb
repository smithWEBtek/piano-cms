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
      redirect to "/students/#{@student.username}"
    else
      erb :'/students/new'
    end
  end

  post '/signup' do 
    if Student.find_by(username: params[:username])
      erb  :'/students/new', locals: {message: "Username is taken, please try a different Username."}
    else
      @student = Student.new(params)
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
      erb :'/students/login', locals: {message: "Incorrect username and/or password."}
    end
  end

  get '/logout' do
    if logged_in?
      current_user
    @goodbye = @student.username
    @student = nil
      session.clear
    end
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
    if logged_in?
      current_user
    @student_list = Student.find_by_slug(params[:slug])
    erb :'/students/show', locals: {message: "Current song list for #{@student_list.username.upcase}: "}
      else
      redirect to '/'
    end
  end

  get '/students/:id/edit' do
    if logged_in?
      current_user
      @student = Student.find_by(params[:slug]) 
      erb :'/students/edit'
    else
      redirect to '/'
    end
  end

  patch '/students/:id/edit' do
    if logged_in?
      current_user
    @student.update(params["student"]) 
    if !@student.save  
       erb :'/students/editfail', locals: {message: "Please enter a valid Username and Password."}
    else
      redirect to "/students/#{@student.username}"
    end
  end
 end
end
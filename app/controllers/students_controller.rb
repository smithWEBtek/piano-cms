class StudentsController < ApplicationController
   
  get '/students' do
    if logged_in?
      current_user
      @all_students = Student.all
      erb :'/students/index.html'
    else
      redirect to '/'
    end
  end

  get '/students/new' do
    erb :'/students/new.html'
  end

  post '/students/new' do
    if Student.find_by(username: params[:username])
      redirect to '/students/new'
    else
      Student.create(params)
    end
    redirect to :'admin/welcome'
  end

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
    else
      redirect to '/students'
    end
  end

  patch '/students/:id' do 
    if current_user.update(params["student"])
      redirect :"/students/#{current_user.id}"
    else
      redirect to :"/students/#{current_user.id}/edit"
    end
  end

  patch '/students/:id/delete' do
    if logged_in? && current_user.username == "admin"
      params["student"]["student_ids"].each do |student_id|
        student = Student.find(student_id)
        student.delete
      end
    end
    redirect to '/admin'
  end 
end
class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect to '/users/:id'
    end
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect to "users/#{@user.id}"
  end

  get '/login' do 
    if !session[:user_id]
      erb :'users/login'
    else
      redirect "/users/#{session[:user_id]}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect to '/signup'
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find(session[:user_id])
      @prods = @user.products
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
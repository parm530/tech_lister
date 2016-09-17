class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/index'
  end

  get '/products/new' do
    if logged_in?
      erb :'/products/create_product'
    else
      redirect to '/signup'
    end
  end

  post '/products/new' do
    @product = Product.create(params[:product])
    @user = User.find(session[:user_id])
    @user.products << @product
    redirect to "/users/#{@user.id}"
  end


end
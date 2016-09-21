class ProductsController < ApplicationController

  get '/products' do
    if(session[:rating] == true)
      session[:rating] = false
      @products = Product.all.sorted_by_rating
    elsif(session[:name] == true)
      session[:name] = false
      @products = Product.all.sorted_by_name
    else
      @products = Product.all
    end
    erb :index
  end

  get '/products/new' do
    if logged_in?
      erb :'/products/new'
    else
      redirect to '/signup'
    end
  end

  post '/products' do
    @user = User.find(session[:user_id])
    if Product.all.detect{|x| x.link == params[:product][:link]}
      @product = Product.find_by(link: params[:product][:link])
      @product.update(type_ids: params[:product][:type_ids])
    else
      @product = Product.create(params[:product])
    end

    @user.products << @product
    redirect to "/users/#{@user.id}"
  end

  delete '/products/:id' do
    @prod = Product.find(params[:id])
    @user = current_user
    if session[:user_id]
      @user.products.delete(@prod.id)
    end
    redirect to "/users/#{session[:user_id]}"
  end

  get '/products/:id/edit' do
    @prod = Product.find(params[:id])
    @user = User.find(session[:user_id])
    if session[:user_id]
      erb :'/products/edit'
    else
      redirect to '/login'
    end
  end

  patch '/products/:id' do
    @user = User.find(session[:user_id])
    @prod = Product.find(params[:id])

    if session[:user_id]
      @prod.update(params[:product])
    end
      redirect to "/users/#{@user.id}"
  end

  post '/rating' do
    session[:rating] = true
    redirect to '/products'
  end

  post '/name' do
    session[:name] = true
    redirect to '/products'
  end


end
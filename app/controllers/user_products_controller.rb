class UserProductsController < ApplicationController

  post '/user_products' do
    if !current_user.products.include?(Product.find(params[:product_id]))
      current_user.user_products.create(params)
    end
    redirect to "/users/#{current_user.id}"
  end


end
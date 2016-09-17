class Product < ActiveRecord::Base

  has_many :user_products
  has_many :users, through: :user_products

  has_many :product_types
  has_many :types, through: :product_types

end
class Type < ActiveRecord::Base

  has_many :product_types
  has_many :products, through: :product_types

end
class Product < ActiveRecord::Base

  has_many :user_products
  has_many :users, through: :user_products

  has_many :product_types
  has_many :types, through: :product_types

  def self.sorted_by_rating
    self.all.sort_by{|prod| prod.rating}.reverse
  end

  def self.sorted_by_name
    self.all.sort_by{|prod| prod.name.downcase}
  end

end
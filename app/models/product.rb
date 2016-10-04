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

  def self.find_product(link, user)
    if Product.all.detect{|x| x.link == link[:link]} && !user.products.detect{|x| x.link == link[:link]}
      @product = Product.find_by(link: link[:link])
      @product.update(type_ids: link[:type_ids])
      user.products << @product
    elsif !Product.all.detect{|x| x.link == link[:link]}
      @product = Product.create(link)
      user.products << @product
    else
      @product = Product.find_by(link: link[:link])
    end
  end

end
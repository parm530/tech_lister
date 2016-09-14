class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.integer :product_id
      t.integer :type_id
    end
  end
end

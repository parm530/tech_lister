class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :content
      t.string :user_id
    end
  end
end

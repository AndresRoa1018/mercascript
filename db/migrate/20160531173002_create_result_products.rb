class CreateResultProducts < ActiveRecord::Migration
  def change
    create_table :result_products do |t|
      t.string :name
      t.string :nick_seller
      t.integer :price
      t.string :url
      t.integer :sold
      t.string :description_html
      t.string :type

      t.timestamps null: false
    end
  end
end

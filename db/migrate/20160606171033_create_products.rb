class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :url
      t.integer :sold
      t.string :description_html
      t.string :type
      t.datetime :created_at
      t.datetime :updated_at
      t.string :source

      t.timestamps null: false
    end
  end
end

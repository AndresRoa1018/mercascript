class CreateSearches < ActiveRecord::Migration
  has_many :photos
  def change
    create_table :searches do |t|
      t.string :name
      t.text :data

      t.timestamps null: false
    end
  end
end

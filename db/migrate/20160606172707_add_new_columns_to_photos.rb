class AddNewColumnsToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :result_product, index: true, foreign_key: true
    add_reference :photos, :search, index: true, foreign_key: true
  end
end

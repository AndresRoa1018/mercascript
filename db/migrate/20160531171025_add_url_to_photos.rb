class AddUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :url, :string
    add_column :photos, :string, :string
  end
end

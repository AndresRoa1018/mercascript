class DeleteStringFromPhotosAndAddNameToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :name, :string
    remove_column :photos, :string, :string
    
  end


end

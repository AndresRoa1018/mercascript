class AddImageUrlToResultProduct < ActiveRecord::Migration
  def change
    add_column :result_products, :image_url, :text
  end
end

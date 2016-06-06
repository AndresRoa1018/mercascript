class AddSearchIdToResultProducts < ActiveRecord::Migration
  def change
    add_column :result_products, :search_id, :integer
  end
end

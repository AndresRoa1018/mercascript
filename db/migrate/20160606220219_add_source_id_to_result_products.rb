class AddSourceIdToResultProducts < ActiveRecord::Migration
  def change
    add_column :result_products, :source_id, :string
  end
end

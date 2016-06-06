class AddSourceToResultProducts < ActiveRecord::Migration
  def change
    add_column :result_products, :source, :string
  end
end

class RenameTypeToIsNewInProductsAndResultProduct < ActiveRecord::Migration
  def up
    [:products, :result_products].each do |table|
      rename_column table, :type, :is_new
      change_column table, :is_new, :boolean
    end
  end

  def down
    [:products, :result_products].each do |table|
      rename_column table, :is_new, :type
      change_column table, :type, :string
    end
  end

end

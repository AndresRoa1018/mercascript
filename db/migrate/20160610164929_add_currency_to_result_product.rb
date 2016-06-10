class AddCurrencyToResultProduct < ActiveRecord::Migration
  def change
    add_column :result_products, :currency, :string
  end
end

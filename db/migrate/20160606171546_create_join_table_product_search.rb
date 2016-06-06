class CreateJoinTableProductSearch < ActiveRecord::Migration
  def change
    create_join_table :products, :searches do |t|
      # t.index [:product_id, :search_id]
      # t.index [:search_id, :product_id]
    end
  end
end

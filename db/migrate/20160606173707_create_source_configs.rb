class CreateSourceConfigs < ActiveRecord::Migration
  def change
    create_table :source_configs do |t|
      t.string :datasource
      t.string :login
      t.string :password
      t.string :domain
      t.boolean :active
      t.text :data

      t.timestamps null: false
    end
  end
end

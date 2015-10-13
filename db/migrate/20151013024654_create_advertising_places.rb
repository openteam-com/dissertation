class CreateAdvertisingPlaces < ActiveRecord::Migration
  def change
    create_table :advertising_places do |t|
      t.integer :views_quantity
      t.string :price_type
      t.float :price
      t.belongs_to :advertising_platform
      t.timestamps null: false
    end
  end
end

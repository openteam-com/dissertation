class CreateAdvertisingTools < ActiveRecord::Migration
  def change
    create_table :advertising_tools do |t|
      t.string :platform_title
      t.string :tool_title
      t.string :showing_place
      t.string :price_model
      t.float :period_cost
      t.integer :period
      t.integer :max_interval
      t.float :average_show
      t.float :ctr
      t.float :click_cost
      t.integer :period_quantity, :default => 0
      t.integer :result, :default => 0
      t.belongs_to :alternative
      t.timestamps null: false
    end
  end
end

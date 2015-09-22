class CreateQuantityGroupingValues < ActiveRecord::Migration
  def change
    create_table :quantity_grouping_values do |t|
      t.string :title
      t.integer :max_count
      t.integer :min_count
      t.belongs_to :grouping_parameter
      t.timestamps null: false
    end
  end
end

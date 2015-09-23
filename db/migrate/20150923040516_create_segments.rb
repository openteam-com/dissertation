class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :title
      t.belongs_to :grouping_value
      t.string :grouping_value_type
      t.belongs_to :grouping
      t.string :ancestry
      t.timestamps null: false
    end
  end
end

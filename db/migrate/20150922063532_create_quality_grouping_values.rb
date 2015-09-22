class CreateQualityGroupingValues < ActiveRecord::Migration
  def change
    create_table :quality_grouping_values do |t|
      t.string :title
      t.text :values
      t.belongs_to :grouping_parameter
      t.timestamps null: false
    end
  end
end

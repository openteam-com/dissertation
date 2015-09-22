class CreateGroupingParameters < ActiveRecord::Migration
  def change
    create_table :grouping_parameters do |t|
      t.string :grouping_field
      t.string :kind
      t.belongs_to :grouping
      t.timestamps null: false
    end
  end
end

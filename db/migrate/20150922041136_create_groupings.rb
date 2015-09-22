class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.string :title
      t.belongs_to :software_product
      t.timestamps null: false
    end
  end
end

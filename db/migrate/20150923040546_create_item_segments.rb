class CreateItemSegments < ActiveRecord::Migration
  def change
    create_table :item_segments do |t|
      t.belongs_to :research_item
      t.belongs_to :segment
      t.timestamps null: false
    end
  end
end

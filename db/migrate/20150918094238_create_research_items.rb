class CreateResearchItems < ActiveRecord::Migration
  def change
    create_table :research_items do |t|
      t.text :data
      t.belongs_to :software_product
      t.timestamps null: false
    end
  end
end

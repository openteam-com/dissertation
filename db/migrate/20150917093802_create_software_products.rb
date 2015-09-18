class CreateSoftwareProducts < ActiveRecord::Migration
  def change
    create_table :software_products do |t|
      t.string :title
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end

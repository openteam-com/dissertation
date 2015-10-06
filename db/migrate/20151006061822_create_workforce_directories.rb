class CreateWorkforceDirectories < ActiveRecord::Migration
  def change
    create_table :workforce_directories do |t|
      t.string :specialists
      t.integer :available_resources
      t.belongs_to :software_product
      t.timestamps null: false
    end
  end
end

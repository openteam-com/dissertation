class CreateReplicationModels < ActiveRecord::Migration
  def change
    create_table :replication_models do |t|
      t.string :title
      t.float :fixed_costs
      t.float :variable_costs
      t.belongs_to :software_product
      t.timestamps null: false
    end
  end
end

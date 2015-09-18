class CreateWorkforces < ActiveRecord::Migration
  def change
    create_table :workforces do |t|
      t.string :specialists
      t.integer :fixed_resources
      t.integer :variable_resources
      t.belongs_to :replication_model
      t.timestamps null: false
    end
  end
end

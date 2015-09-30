class CreateParameterWeights < ActiveRecord::Migration
  def change
    create_table :parameter_weights do |t|
      (1..10).each do |index|
        t.float "parameter#{index}", :default => 0
      end
      t.belongs_to :grouping
      t.timestamps null: false
    end
  end
end

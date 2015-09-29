class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.belongs_to :segment
      t.belongs_to :replication_model
      (1..10).each do |index|
        t.text "parameter#{index}", :default => [0,0,0]
      end
      t.timestamps null: false
    end
  end
end

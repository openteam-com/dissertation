class CreateAccomodationWaves < ActiveRecord::Migration
  def change
    create_table :accomodation_waves do |t|
      t.integer :duration
      t.belongs_to :alternative
      t.timestamps null: false
    end
  end
end

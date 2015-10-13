class CreateAdvertisingPlatforms < ActiveRecord::Migration
  def change
    create_table :advertising_platforms do |t|
      t.string :title
      t.string :url
      t.belongs_to :accomodation_wave
      t.timestamps null: false
    end
  end
end

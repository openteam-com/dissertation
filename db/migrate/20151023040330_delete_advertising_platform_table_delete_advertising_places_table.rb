class DeleteAdvertisingPlatformTableDeleteAdvertisingPlacesTable < ActiveRecord::Migration
  def change
    drop_table :advertising_platforms
    drop_table :advertising_places
  end
end

class AddAdvertisingToolsToAccomodationWaves < ActiveRecord::Migration
  def change
    add_column :accomodation_waves, :advertising_tools, :text, :defaults => []
  end
end

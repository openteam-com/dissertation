class AddAttachmentResearchItemsCsvToSoftwareProducts < ActiveRecord::Migration
  def self.up
    change_table :software_products do |t|
      t.attachment :research_items_csv
    end
  end

  def self.down
    remove_attachment :software_products, :research_items_csv
  end
end

class AddAttachmentAdvertisingToolCsvToAlternatives < ActiveRecord::Migration
  def self.up
    change_table :alternatives do |t|
      t.attachment :advertising_tool_csv
    end
  end

  def self.down
    remove_attachment :alternatives, :advertising_tool_csv
  end
end

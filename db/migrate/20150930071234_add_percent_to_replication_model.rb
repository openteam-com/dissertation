class AddPercentToReplicationModel < ActiveRecord::Migration
  def change
    add_column :replication_models, :investition_percent, :integer
  end
end

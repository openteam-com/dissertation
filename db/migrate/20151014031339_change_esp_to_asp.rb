class ChangeEspToAsp < ActiveRecord::Migration
  def change
    ReplicationModel.where(:title => :esp).update_all(:title => :asp)
  end
end

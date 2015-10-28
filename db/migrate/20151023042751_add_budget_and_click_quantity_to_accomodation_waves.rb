class AddBudgetAndClickQuantityToAccomodationWaves < ActiveRecord::Migration
  def change
    add_column :accomodation_waves, :budget, :integer
  end
end

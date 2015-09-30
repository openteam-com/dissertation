class AddAverageCostPertCoeficoentToAlternative < ActiveRecord::Migration
  def change
    add_column :alternatives, :average_cost, :float, :default => 0
    add_column :alternatives, :pessimistic_profit, :integer, :default => 0
    add_column :alternatives, :real_profit, :integer, :default => 0
    add_column :alternatives, :optimistic_profit, :integer, :default => 0
  end
end

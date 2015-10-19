class AddRglpkResultsColumnToAlternative < ActiveRecord::Migration
  def change
    (1..4).each do |index|
      add_column :alternatives, "step#{index}", :boolean
    end
  end
end

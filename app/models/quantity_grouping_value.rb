class QuantityGroupingValue < ActiveRecord::Base
  belongs_to :grouping_parameter

  validates_presence_of :title, :max_count, :min_count
end

# == Schema Information
#
# Table name: quantity_grouping_values
#
#  id                    :integer          not null, primary key
#  title                 :string
#  max_count             :integer
#  min_count             :integer
#  grouping_parameter_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

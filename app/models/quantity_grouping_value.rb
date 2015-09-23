class QuantityGroupingValue < ActiveRecord::Base
  has_many :segments, :as => :grouping_value, :dependent => :destroy
  belongs_to :grouping_parameter

  validates_presence_of :title, :max_count, :min_count

  def prefix
    "quantity"
  end
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

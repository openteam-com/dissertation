class QualityGroupingValue < ActiveRecord::Base
  belongs_to :grouping_parameter

  validates_presence_of :title, :values

  serialize :values, Array

  before_save :compact_values

  private

  def compact_values
    self.values.delete_if {|v| v.blank?}
  end
end

# == Schema Information
#
# Table name: quality_grouping_values
#
#  id                    :integer          not null, primary key
#  title                 :string
#  values                :text
#  grouping_parameter_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

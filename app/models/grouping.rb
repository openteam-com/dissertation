class Grouping < ActiveRecord::Base
  has_many :segments, :dependent => :destroy
  has_many :grouping_parameters, :dependent => :destroy
  belongs_to :software_product

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :title

  def segments_count
    values_array = grouping_parameters.map{ |parameter| parameter.grouping_values.count}
    values_array.map.with_index{ |_,index| multiply_array(values_array, index+1) }.inject(:+)
  end

  private
  def multiply_array(arr, quantity)
    arr.take(quantity).inject(:*)
  end
end

# == Schema Information
#
# Table name: groupings
#
#  id                  :integer          not null, primary key
#  title               :string
#  software_product_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

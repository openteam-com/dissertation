class Grouping < ActiveRecord::Base
  has_many :segments, :dependent => :destroy
  has_many :grouping_parameters, :dependent => :destroy
  belongs_to :software_product

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :title

  def rebuild_segments
    Segment.roots.where(:grouping_value_id => grouping_parameters.map(&:grouping_values).flatten).destroy_all
    recalculate_segments
  end

  def recalculate_segments(previous_segment = nil, grouping_parameter = nil, level = 0)
    grouping_parameter ||= grouping_parameters.first
    grouping_parameter.grouping_values.each do |value|
      segment_title = value.title
      segment = Segment.create! :title => segment_title, :grouping_value => value, :parent => previous_segment, :grouping => self
      recalculate_segments(segment, grouping_parameters[level+1], level+1) if level+1 < grouping_parameters.count
    end
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

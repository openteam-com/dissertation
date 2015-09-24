class Segment < ActiveRecord::Base
  has_many :item_segments,      :dependent => :destroy
  has_many :research_items,     :through => :item_segments
  belongs_to :grouping
  belongs_to :grouping_value,   :polymorphic => true

  has_ancestry

  after_create :associate_research_items

  private

  def associate_research_items
    (parent || grouping_value.grouping_parameter.grouping.software_product).research_items.each do |item|
      send("#{grouping_value.prefix}_item", item)
    end
  end

  def quality_item(item)
    item_parameter_value = item.data[grouping_value.grouping_parameter.grouping_field]
    item_segments.create(research_item_id: item.id) if grouping_value.values.include?(item_parameter_value)
  end

  def quantity_item(item)
    item_parameter_value = item.data[grouping_value.grouping_parameter.grouping_field].to_i
    item_segments.create(research_item_id: item.id) if item_parameter_value >= grouping_value.min_count && item_parameter_value <= grouping_value.max_count
  end
end

# == Schema Information
#
# Table name: segments
#
#  id                  :integer          not null, primary key
#  title               :string
#  grouping_value_id   :integer
#  grouping_value_type :string
#  grouping_id         :integer
#  ancestry            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
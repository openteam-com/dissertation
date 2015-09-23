class ItemSegment < ActiveRecord::Base
  belongs_to :research_item
  belongs_to :segment

  validates_uniqueness_of :research_item_id, :scope => :segment_id
end

# == Schema Information
#
# Table name: item_segments
#
#  id               :integer          not null, primary key
#  research_item_id :integer
#  segment_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

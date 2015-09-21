class ResearchItem < ActiveRecord::Base
  belongs_to :software_product

  serialize :data, OpenStruct
end

# == Schema Information
#
# Table name: research_items
#
#  id                  :integer          not null, primary key
#  data                :text
#  software_product_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

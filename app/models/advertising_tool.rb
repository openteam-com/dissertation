class AdvertisingTool < ActiveRecord::Base
  belongs_to :alternative

  before_save :set_period_cost

  def set_period_cost
    if price_model == "CPC"
      self.period_cost = average_show * ctr/100 * click_cost
    end
  end

  def productivity
    (ctr/100) * average_show
  end
end

# == Schema Information
#
# Table name: advertising_tools
#
#  id              :integer          not null, primary key
#  platform_title  :string
#  tool_title      :string
#  showing_place   :string
#  price_model     :string
#  period_cost     :float
#  period          :integer
#  max_interval    :integer
#  average_show    :float
#  ctr             :float
#  click_cost      :float
#  period_quantity :integer          default(0)
#  alternative_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

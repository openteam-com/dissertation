class AccomodationWave < ActiveRecord::Base
  belongs_to :alternative

  validates_presence_of :duration, :budget, :advertising_tools

  serialize :advertising_tools, Array
end

# == Schema Information
#
# Table name: accomodation_waves
#
#  id                :integer          not null, primary key
#  duration          :integer
#  alternative_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  budget            :integer
#  click_quantity    :integer
#  advertising_tools :text
#

class AccomodationWave < ActiveRecord::Base
  belongs_to :alternative
  has_many :advertising_platforms, :dependent => :destroy

  accepts_nested_attributes_for :advertising_platforms, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :duration
end

# == Schema Information
#
# Table name: accomodation_waves
#
#  id             :integer          not null, primary key
#  duration       :integer
#  alternative_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

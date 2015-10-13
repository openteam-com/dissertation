class AdvertisingPlatform < ActiveRecord::Base
  belongs_to :accomodation_wave
  has_many :advertising_places, :dependent => :destroy

  accepts_nested_attributes_for :advertising_places, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :title, :url
end

# == Schema Information
#
# Table name: advertising_platforms
#
#  id                   :integer          not null, primary key
#  title                :string
#  url                  :string
#  accomodation_wave_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

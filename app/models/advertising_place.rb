class AdvertisingPlace < ActiveRecord::Base
  belongs_to :advertising_platform

  validates_presence_of :views_quantity, :price_type, :price

  extend Enumerize
  enumerize :price_type, in: [:thousand_clicks, :day, :click], predicates: true
end

# == Schema Information
#
# Table name: advertising_places
#
#  id                      :integer          not null, primary key
#  views_quantity          :integer
#  price_type              :string
#  price                   :float
#  advertising_platform_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

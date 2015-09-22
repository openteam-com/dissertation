class Grouping < ActiveRecord::Base
  has_many :grouping_parameters, :dependent => :destroy
  belongs_to :software_product

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :title
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

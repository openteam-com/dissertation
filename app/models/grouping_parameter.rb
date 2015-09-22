class GroupingParameter < ActiveRecord::Base
  has_many :quantity_grouping_values, :dependent => :destroy
  has_many :quality_grouping_values,  :dependent => :destroy
  belongs_to :grouping

  validates_presence_of :grouping_field, :kind

  accepts_nested_attributes_for :quality_grouping_values,  :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :quantity_grouping_values, :allow_destroy => true, :reject_if => :all_blank

  extend Enumerize
  enumerize :kind, :in => [:quality, :quantity], :predicates => true

  def grouping_values
    send "#{kind}_grouping_values"
  end
end

# == Schema Information
#
# Table name: grouping_parameters
#
#  id             :integer          not null, primary key
#  grouping_field :string
#  kind           :string
#  grouping_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

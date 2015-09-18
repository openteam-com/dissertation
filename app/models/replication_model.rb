class ReplicationModel < ActiveRecord::Base
  belongs_to :software_product
  has_many :workforces

  validates_presence_of :title, :fixed_costs, :variable_costs

  accepts_nested_attributes_for :workforces, :allow_destroy => true, :reject_if => :all_blank

  extend Enumerize
  enumerize :title, in: [:saas, :esp, :spo, :license], predicates: true
end

# == Schema Information
#
# Table name: replication_models
#
#  id                  :integer          not null, primary key
#  title               :string
#  fixed_costs         :float
#  variable_costs      :float
#  software_product_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
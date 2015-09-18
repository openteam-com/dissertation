class Workforce < ActiveRecord::Base
  belongs_to :replication_model

  validates_presence_of :specialists, :fixed_resources, :variable_resources
end

# == Schema Information
#
# Table name: workforces
#
#  id                   :integer          not null, primary key
#  specialists          :string
#  fixed_resources      :integer
#  variable_resources   :integer
#  replication_model_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

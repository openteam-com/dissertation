class SoftwareProduct < ActiveRecord::Base
  has_many :replication_models
  belongs_to :user

  validates_presence_of :title
end

# == Schema Information
#
# Table name: software_products
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

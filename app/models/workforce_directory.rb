class WorkforceDirectory < ActiveRecord::Base
  belongs_to :software_product
end

# == Schema Information
#
# Table name: workforce_directories
#
#  id                  :integer          not null, primary key
#  specialists         :string
#  available_resources :integer
#  software_product_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

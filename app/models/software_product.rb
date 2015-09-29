class SoftwareProduct < ActiveRecord::Base
  has_many :replication_models, :dependent => :destroy
  has_many :research_items,     :dependent => :destroy
  has_many :groupings,          :dependent => :destroy
  has_one :parameter_weight,    :dependent => :destroy
  belongs_to :user

  after_create :create_parameters_weight

  has_attached_file :research_items_csv
  validates_attachment_content_type :research_items_csv, :content_type => /.*csv\Z/

  validates_presence_of :title

  def limited_research_items
    research_items.limit(3).pluck(:data).map(&:to_h)
  end

  def research_items_headers
    research_items.first.data.to_h.keys
  end

  def uniq_values_for_quality_values(option)
    research_items.map {|item| item.data[option]}.uniq
  end

  def create_parameters_weight
    create_parameter_weight!
  end
end

# == Schema Information
#
# Table name: software_products
#
#  id                              :integer          not null, primary key
#  title                           :string
#  user_id                         :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  research_items_csv_file_name    :string
#  research_items_csv_content_type :string
#  research_items_csv_file_size    :integer
#  research_items_csv_updated_at   :datetime
#

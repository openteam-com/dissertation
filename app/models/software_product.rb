class SoftwareProduct < ActiveRecord::Base
  has_many :replication_models,    :dependent => :destroy
  has_many :research_items,        :dependent => :destroy
  has_many :groupings,             :dependent => :destroy
  has_many :workforce_directories, :dependent => :destroy
  belongs_to :user

  has_attached_file :research_items_csv
  validates_attachment_content_type :research_items_csv, :content_type => /.*csv\Z/

  accepts_nested_attributes_for :workforce_directories, :allow_destroy => true, :reject_if => :all_blank

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

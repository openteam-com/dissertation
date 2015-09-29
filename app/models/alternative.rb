class Alternative < ActiveRecord::Base
  belongs_to :segment
  belongs_to :replication_model

  delegate :full_name, :to => :segment, :prefix => true
  delegate :title, :to => :replication_model, :prefix => true

  (1..10).each do |index|
    serialize "parameter#{index}", Array
  end

  def pert(parameter_number)
    optimistic, biggest, worst = send("parameter#{parameter_number}").map(&:to_f)
    (optimistic + 4 * biggest + worst) / 6
  end

  def parameter_weight
    @parameter_weight ||= segment.grouping.software_product.parameter_weight
  end

  def final_coef
    (1..10).inject(0){|sum, index|
      sum+= pert(index) * parameter_weight.normalize_weight(index)
      sum
    }
  end
end

# == Schema Information
#
# Table name: alternatives
#
#  id                   :integer          not null, primary key
#  segment_id           :integer
#  replication_model_id :integer
#  parameter1           :text
#  parameter2           :text
#  parameter3           :text
#  parameter4           :text
#  parameter5           :text
#  parameter6           :text
#  parameter7           :text
#  parameter8           :text
#  parameter9           :text
#  parameter10          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

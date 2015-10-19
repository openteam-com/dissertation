class Alternative < ActiveRecord::Base
  belongs_to :segment
  belongs_to :replication_model

  has_many :accomodation_waves, :class_name => "AccomodationWave", :dependent => :destroy

  delegate :full_name, :to => :segment, :prefix => true
  delegate :title, :to => :replication_model, :prefix => true
  delegate :investition_percent, :fixed_costs, :variable_costs, :workforces, :to => :replication_model

  (1..10).each do |index|
    serialize "parameter#{index}", Array
  end

  def pert(parameter_number)
    optimistic, real, pessimistic = send("parameter#{parameter_number}").map(&:to_f)
    (optimistic + 4 * real + pessimistic) / 6
  end

  def parameter_weight
    @parameter_weight ||= segment.grouping.parameter_weight
  end

  def attractiveness
    (1..10).inject(0){|sum, index|
      sum + pert(index) * parameter_weight.normalize_weight(index)
    }
  end

  def profit
    sales - (profit_pert * variable_costs)
  end

  def investiton
    profit / 100 * investition_percent
  end

  def sales
    profit_pert * average_cost
  end

  def workforce_values
    workforces.inject({}){ |hash, workforce|
      hash[workforce.specialists] = profit_pert * workforce.variable_resources
      hash
    }
  end

  private

  def profit_pert
    (optimistic_profit + 4 * real_profit + pessimistic_profit)/6
  end
end

# == Schema Information
#
# Table name: alternatives
#
#  id                   :integer          not null, primary key
#  segment_id           :integer
#  replication_model_id :integer
#  parameter1           :text             default([0, 0, 0])
#  parameter2           :text             default([0, 0, 0])
#  parameter3           :text             default([0, 0, 0])
#  parameter4           :text             default([0, 0, 0])
#  parameter5           :text             default([0, 0, 0])
#  parameter6           :text             default([0, 0, 0])
#  parameter7           :text             default([0, 0, 0])
#  parameter8           :text             default([0, 0, 0])
#  parameter9           :text             default([0, 0, 0])
#  parameter10          :text             default([0, 0, 0])
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  average_cost         :float            default(0.0)
#  pessimistic_profit   :integer          default(0)
#  real_profit          :integer          default(0)
#  optimistic_profit    :integer          default(0)
#  step1                :boolean
#  step2                :boolean
#  step3                :boolean
#  step4                :boolean
#

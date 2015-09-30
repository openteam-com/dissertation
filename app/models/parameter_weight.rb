class ParameterWeight < ActiveRecord::Base
  def params_sum
    @params_sum ||= attributes.except("id", "created_at", "updated_at").values.sum
  end

  def normalize_weight(index)
    send("parameter#{index}")/params_sum
  end
end

# == Schema Information
#
# Table name: parameter_weights
#
#  id          :integer          not null, primary key
#  parameter1  :float            default(0.0)
#  parameter2  :float            default(0.0)
#  parameter3  :float            default(0.0)
#  parameter4  :float            default(0.0)
#  parameter5  :float            default(0.0)
#  parameter6  :float            default(0.0)
#  parameter7  :float            default(0.0)
#  parameter8  :float            default(0.0)
#  parameter9  :float            default(0.0)
#  parameter10 :float            default(0.0)
#  grouping_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

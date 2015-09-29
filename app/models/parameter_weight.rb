class ParameterWeight < ActiveRecord::Base
  def params_sum
    @params_sum ||= attributes.except("id", "created_at", "updated_at").values.sum
  end

  def normalize_weight(index)
    send("parameter#{index}")/params_sum
  end
end

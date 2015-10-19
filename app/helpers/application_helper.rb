module ApplicationHelper
  def solution_step_collection(step)
    params_values = params[:solution].values.map(&:to_sym)
    index = params[:solution].keys.index(step)
    maximization + minimization - params_values[0..index]
  end

  def maximization
    [:max_profit, :max_attractiveness]
  end

  def minimization
    [:min_investition, :min_segments]
  end

  def step_visibility?(step)
    params[:solution] && params[:solution][step].present?
  end

  def step_value(step)
    params[:solution].try(:[], step)
  end

  def concession_value(step)
    params[:solution].try(:[], "#{step_value(step)}_concession") || 0
  end

  def stage
    params[:stage] || 'first'
  end
end

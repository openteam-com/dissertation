module ApplicationHelper
  def stage
    params[:stage] || 'first'
  end
end

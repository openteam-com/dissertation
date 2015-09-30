class AlternativesController < ApplicationController
  before_action :software_product, :grouping

  layout 'segments'

  def index
    @alternatives = @grouping.alternatives
  end

  def edit
    @alternative = Alternative.find(params[:id])
  end

  def update
    @alternative = Alternative.find(params[:id])
    @alternative.update(alternative_params)
    respond_with @software_product, @grouping, @alternative, :location =>  software_product_grouping_alternatives_path(@software_product, @grouping)
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def alternative_params
      profit_array = %w(average_cost pessimistic_profit real_profit optimistic_profit)
      parameters_array = (1..10).inject([]){ |array,index|
        array.push("parameter#{index}" => [])
        array
      }
      params.require(:alternative).permit(profit_array + parameters_array)
    end
end

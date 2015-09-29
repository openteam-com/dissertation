class ParameterWeightsController < ApplicationController
  before_action :software_product, :grouping, :add_breadcrumbs

  layout 'segments'

  def show
    @parameter_weight = ParameterWeight.find(params[:id])
    add_breadcrumb "Веса параметров", software_product_grouping_parameter_weight_path(@software_product, @grouping, @parameter_weight)
  end

  def edit
    @parameter_weight = ParameterWeight.find(params[:id])
  end

  def update
    @parameter_weight = ParameterWeight.find(params[:id])
    @parameter_weight.update(parameter_weight_params)
    respond_with @software_product, @grouping, @parameter_weight
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def parameter_weight_params
      parameters_array = (1..10).inject([]){ |array,index|
        array.push("parameter#{index}")
        array
      }
      params.require(:parameter_weight).permit(parameters_array)
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end
end

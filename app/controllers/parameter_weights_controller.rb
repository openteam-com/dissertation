class ParameterWeightsController < ApplicationController
  helper_method :stage
  before_action :software_product, :grouping, :add_breadcrumbs

  layout 'software_product'

  def show
    @parameter_weight = ParameterWeight.find(params[:id])
    add_breadcrumb "Веса параметров"
  end

  def edit
    @parameter_weight = ParameterWeight.find(params[:id])
    add_breadcrumb "Редактировать веса параметров"
  end

  def update
    @parameter_weight = ParameterWeight.find(params[:id])
    @parameter_weight.update(parameter_weight_params)
    respond_with @software_product, @grouping, @parameter_weight
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product, :stage => "first")
      add_breadcrumb "Группировка '#{@grouping.title}'", software_product_path(@software_product, :stage => "second")
    end

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

    def stage
      params[:stage] || "third"
    end
end

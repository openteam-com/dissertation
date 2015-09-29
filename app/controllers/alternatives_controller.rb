class AlternativesController < ApplicationController
  before_action :software_product, :grouping, :add_breadcrumbs

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
      parameters_array = (1..10).inject([]){ |array,index|
        array.push("parameter#{index}" => [])
        array
      }
      params.require(:alternative).permit(parameters_array)
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
      add_breadcrumb "Альтернативы", software_product_grouping_alternatives_path(@software_product, @grouping)
    end
end

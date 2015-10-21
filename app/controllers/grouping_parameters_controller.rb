class GroupingParametersController < ApplicationController
  helper_method :stage
  before_action :software_product, :grouping, :add_breadcrumbs

  layout "software_product"

  def edit
    @grouping_parameter = GroupingParameter.find(params[:id])
    add_breadcrumb "Редактирование параметра группировки", edit_software_product_grouping_grouping_parameter_path(@software_product, @grouping, @grouping_parameter)
  end

  def update
    @grouping_parameter = GroupingParameter.find(params[:id])
    @grouping_parameter.update(grouping_parameter_params)
    respond_with @software_product, @grouping, @grouping_parameter, :location =>  software_product_path(@software_product, :stage => stage)
  end

  def destroy
    GroupingParameter.find(params[:id]).destroy
    redirect_to software_product_path(@software_product, :stage => stage)
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def grouping_parameter_params
      params.require(:grouping_parameter).permit(:quantity_grouping_values_attributes => [:id, :title, :min_count, :max_count, :_destroy],
                                                 :quality_grouping_values_attributes => [:id, :title, :_destroy, :values => []])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product, :stage => stage)
    end

    def stage
      params[:stage] || "second"
    end
end

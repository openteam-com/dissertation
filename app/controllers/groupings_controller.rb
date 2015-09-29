class GroupingsController < ApplicationController
  before_action :software_product, :add_breadcrumbs

  def new
    add_breadcrumb "Новая группировка", new_software_product_grouping_path(@software_product)
    @grouping = @software_product.groupings.new
  end

  def create
    @grouping = @software_product.groupings.create(groupings_params)
    respond_with @grouping, :location =>  software_product_path(@software_product)
  end

  def edit
    @grouping = Grouping.find(params[:id])
    add_breadcrumb "Редактировать группировку",  edit_software_product_grouping_path(@software_product, @grouping)
  end

  def update
    @grouping = Grouping.find(params[:id])
    @grouping.update(groupings_params)
    respond_with @software_product, @grouping, :location =>  software_product_path(@software_product)
  end

  def destroy
    Grouping.find(params[:id]).destroy
    redirect_to software_product_path(@software_product)
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def groupings_params
      params.require(:grouping).permit(:title, :grouping_parameters_attributes => [:id, :grouping_field, :kind, :_destroy])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end
end

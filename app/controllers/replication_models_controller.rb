class ReplicationModelsController < ApplicationController
  before_action :software_product, :add_breadcrumbs

  layout 'software_product'

  def new
    add_breadcrumb "Новая модель тиражирования", new_software_product_replication_model_path(@software_product)
    @replication_model = @software_product.replication_models.new
  end

  def create
    @replication_model = @software_product.replication_models.create(replication_model_params)
    respond_with @replication_model, :location =>  software_product_path(@software_product)
  end

  def edit
    @replication_model = ReplicationModel.find(params[:id])
    add_breadcrumb "Редактировать модель тиражирования", edit_software_product_replication_model_path(@software_product, @replication_model)
  end

  def update
    @replication_model = ReplicationModel.find(params[:id])
    @replication_model.update(replication_model_params)
    respond_with @software_product, @replication_model, :location =>  software_product_path(@software_product)
  end

  def destroy
    ReplicationModel.find(params[:id]).destroy
    redirect_to software_product_path(@software_product)
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def replication_model_params
      params.require(:replication_model).permit(:title, :fixed_costs, :variable_costs, :investition_percent,
                                                :workforces_attributes => [:id, :specialists, :fixed_resources, :variable_resources, :_destroy])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end
end

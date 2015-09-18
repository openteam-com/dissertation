class SoftwareProductsController < ApplicationController
  before_action :authenticate_user!

  add_breadcrumb "Список программных продуктов", :software_products_path

  def index
    @software_products = SoftwareProduct.all
  end

  def new
    add_breadcrumb "Новый программный продукт", new_software_product_path
    @software_product = SoftwareProduct.new
  end

  def create
    @software_product = SoftwareProduct.create(software_product_params)
    respond_with @software_product
  end

  def show
    @software_product = SoftwareProduct.find(params[:id])
    add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
  end

  def edit
    @software_product = SoftwareProduct.find(params[:id])
    add_breadcrumb "Редактирование программного продукта '#{@software_product.title}'", edit_software_product_path(@software_product)
  end

  def update
    @software_product = SoftwareProduct.find(params[:id])
    @software_product.update(software_product_params)
    respond_with @software_product
  end

  def destroy
    SoftwareProduct.find(params[:id]).destroy
    redirect_to software_products_path
  end

  private
    def software_product_params
      params.require(:software_product).permit(:title, :user_id)
    end
end

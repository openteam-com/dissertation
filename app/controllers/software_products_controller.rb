class SoftwareProductsController < ApplicationController
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
    add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
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

  def upload_csv
    @software_product = SoftwareProduct.find(params[:software_product_id])
    if @software_product.update(software_product_params)
      path = "#{Rails.root}/public/#{@software_product.research_items_csv.url}".split('?').first
      job_id = ResearchItemsWorker.perform_async(path, @software_product.id)
      redirect_to software_product_path(@software_product, :job_id => job_id, :pb_kind => "csv_upload")
    else
      render :show
    end
  end

  def destroy_research_items
    @software_product = SoftwareProduct.find(params[:software_product_id])
    @software_product.update_attributes(:research_items_csv => nil)
    job_id = DestroyResearchItems.perform_async(@software_product.id)
    redirect_to software_product_path(@software_product, :job_id => job_id, :pb_kind => "destroy_research_items")
  end

  private
    def software_product_params
      params.require(:software_product).permit(:title, :user_id, :research_items_csv)
    end
end

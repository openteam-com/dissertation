class SoftwareProductsController < ApplicationController
  helper_method :stage
  add_breadcrumb "Список программных продуктов", :software_products_path

  layout 'software_product', :except => [:index]

  def index
    @software_products = current_user.software_products
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
    @software_product = SoftwareProduct.find(params[:id])
    if @software_product.update(software_product_params)
      path = "#{Rails.root}/public/#{@software_product.research_items_csv.url}".split('?').first
      job_id = ResearchItemsWorker.perform_async(path, @software_product.id)
      redirect_to software_product_path(@software_product, :job_id => job_id, :pb_kind => "csv_upload", :stage => "second")
    else
      render :show
    end
  end

  def destroy_research_items
    @software_product = SoftwareProduct.find(params[:id])
    @software_product.update_attributes(:research_items_csv => nil)
    job_id = DestroyResearchItems.perform_async(@software_product.id)
    redirect_to software_product_path(@software_product, :job_id => job_id, :pb_kind => "destroy_research_items", :stage => "second")
  end

  private
    def software_product_params
      params.require(:software_product).permit(:title, :user_id, :research_items_csv,
                                              :workforce_directories_attributes => [:id, :specialists, :available_resources, :_destroy])
    end

    def stage
      params[:stage] || "first"
    end
end

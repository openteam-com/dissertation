class ResearchItemsController < ApplicationController
  def index
    @software_product = SoftwareProduct.find(params[:software_product_id])
    research_items = @software_product.research_items.pluck(:data).map(&:to_h)
    @research_items = Kaminari.paginate_array(research_items).page(params[:page]).per(25)

    add_breadcrumb "Список программных продуктов", software_products_path
    add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    add_breadcrumb "Список объектов исследования", software_product_research_items_path(@software_product)
  end
end

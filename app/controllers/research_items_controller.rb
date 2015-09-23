class ResearchItemsController < ApplicationController
  def index
    @software_product = SoftwareProduct.find(params[:software_product_id])
    research_items = research_items_collection
    @research_items = Kaminari.paginate_array(research_items).page(params[:page]).per(25)

    add_breadcrumb "Список программных продуктов", software_products_path
    add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    add_breadcrumb "Сегменты", software_product_grouping_segments_path(@software_product, Segment.find(params[:segment_id]).grouping) if params[:segment_id]
    add_breadcrumb "Список объектов исследования", software_product_research_items_path(@software_product)
  end

  private
    def research_items_collection
      research_items = params[:segment_id] ?  Segment.find(params[:segment_id]).research_items : @software_product.research_items
      research_items.pluck(:data).map(&:to_h)
    end
end

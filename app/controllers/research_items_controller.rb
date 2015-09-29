class ResearchItemsController < ApplicationController
  def index
    @software_product = SoftwareProduct.find(params[:software_product_id])
    research_items = research_items_collection
    @research_items = Kaminari.paginate_array(research_items).page(params[:page]).per(25)

    add_breadcrumb "Список программных продуктов", software_products_path
    add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    if params[:segment_id]
      add_breadcrumb "Сегменты", software_product_grouping_segments_path(@software_product, segment.grouping)
      add_breadcrumb "Сегмент #{segment.full_name}", software_product_research_items_path(@software_product)
    else
      add_breadcrumb "Список объектов исследования", software_product_research_items_path(@software_product)
    end
  end

  private
    def research_items_collection
      research_items = params[:segment_id] ?  Segment.find(params[:segment_id]).research_items : @software_product.research_items
      research_items.pluck(:data).map(&:to_h)
    end

    def segment
      @segment ||= Segment.find(params[:segment_id])
    end
end

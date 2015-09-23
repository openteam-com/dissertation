class SegmentsController < ApplicationController
  before_action :authenticate_user!, :software_product, :grouping, :add_breadcrumbs

  def index
    if @grouping.segments.present?
      @segments = @grouping.segments
    else
      @grouping.recalculate_segments
      @segments = @grouping.segments
    end
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end
end

class SegmentsController < ApplicationController
  before_action :authenticate_user!, :software_product, :grouping, :add_breadcrumbs

  def index
    add_breadcrumb "Сегменты", software_product_grouping_segments_path(@software_product, @grouping)

    if @grouping.segments.present? && !params[:job_id]
      @segments = @grouping.segments
    elsif params[:job_id]
      return
    else
      job_id = SegmentsWorker.perform_async(@grouping.id)
      redirect_to  software_product_grouping_segments_path(@software_product, @grouping, :job_id => job_id, :pb_kind => "segments")
    end
  end

  def edit

  end

  def update

  end

  def rebuild_segments
    job_id = RebuildSegmentsWorker.perform_async(@grouping.id)
    redirect_to  software_product_grouping_segments_path(@software_product, @grouping, :job_id => job_id, :pb_kind => "rebuild_segments")
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end
end

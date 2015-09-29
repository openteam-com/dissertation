class SegmentsController < ApplicationController
  before_action :software_product, :grouping, :add_breadcrumbs

  layout 'segments'

  def index
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
    @segment = Segment.find(params[:id])
    add_breadcrumb "Сегмент #{@segment.full_name}", edit_software_product_grouping_segment_path(@software_product, @grouping, @segment)
  end

  def update
    @segment = Segment.find(params[:id])
    @segment.update(groupings_params)
    respond_with @software_product, @grouping, @segment, :location =>  software_product_grouping_segments_path(@software_product, @grouping, :childless => true)
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

    def groupings_params
      params.require(:segment).permit(:replication_model_ids => [])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
      add_breadcrumb "Сегменты", software_product_grouping_segments_path(@software_product, @grouping)
    end
end

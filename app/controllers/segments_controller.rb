class SegmentsController < ApplicationController
  helper_method :stage
  before_action :software_product, :grouping, :add_breadcrumbs

  layout 'software_product'

  def new
    @segment = Segment.new
    add_breadcrumb "Новый сегмент"
  end

  def create
    @segment = @grouping.segments.create(segment_params)
    respond_with @segment, :location =>  software_product_grouping_segments_path(@software_product, @grouping, :stage => stage)
  end

  def index
    if (@grouping.segments.present? && !params[:job_id]) || !@grouping.grouping_parameters?
      @segments = @grouping.segments
      add_breadcrumb "Список сегментов"
    elsif params[:job_id]
      return
    else
      job_id = SegmentsWorker.perform_async(@grouping.id)
      redirect_to  software_product_grouping_segments_path(@software_product, @grouping, :job_id => job_id, :pb_kind => "segments", :stage => stage)
      add_breadcrumb "Подсчет сегментов"
    end
  end

  def edit
    @segment = Segment.find(params[:id])
    add_breadcrumb "Сегмент #{@segment.full_name}"
  end

  def update
    @segment = Segment.find(params[:id])
    @segment.update(segment_params)
    respond_with @software_product, @grouping, @segment, :location =>  software_product_grouping_segments_path(@software_product, @grouping, :childless => true, :stage => stage)
  end

  def rebuild_segments
    job_id = RebuildSegmentsWorker.perform_async(@grouping.id)
    redirect_to  software_product_grouping_segments_path(@software_product, @grouping, :job_id => job_id, :pb_kind => "rebuild_segments", :stage => stage)
      add_breadcrumb "Пересчет сегментов"
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product, :stage => "first")
      add_breadcrumb "Группировка '#{@grouping.title}'", software_product_path(@software_product, :stage => "second")
    end

    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||=Grouping.find(params[:grouping_id])
    end

    def segment_params
      params.require(:segment).permit(:title, :replication_model_ids => [])
    end

    def stage
      params[:stage] || "third"
    end
end

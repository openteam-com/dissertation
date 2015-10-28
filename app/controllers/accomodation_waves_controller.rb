class AccomodationWavesController < ApplicationController
  helper_method :stage
  before_action :software_product, :grouping, :alternative, :add_breadcrumbs

  layout 'software_product'

  def new
    @accomodation_wave = AccomodationWave.new
    add_breadcrumb "Новая волна"
  end

  def create
    @accomodation_wave = @alternative.accomodation_waves.create(accomodation_wave_params)
    respond_with @accomodation_wave, :location => software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
  end

  def show
    @results = @alternative.advertising_tools.where("result > ?", 0)
    add_breadcrumb "Список оптимальных инструментов"
    ToolsRglpkWrapper.new(alternative, AccomodationWave.find(params[:id])).solve
  end

  def edit
    @accomodation_wave = AccomodationWave.find(params[:id])
    add_breadcrumb "Редактирвать волну"
  end

  def update
    @accomodation_wave = AccomodationWave.find(params[:id])
    @accomodation_wave.update(accomodation_wave_params)
    respond_with @software_product, @grouping, @alternative, @accomodation_wave, :location => software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
  end

  def destroy
    AccomodationWave.find(params[:id]).destroy
    redirect_to software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product, :stage => "first")
      add_breadcrumb "Группировка '#{@grouping.title}'", software_product_path(@software_product, :stage => "second")
      add_breadcrumb "Список альтернатив", selected_alternatives_software_product_grouping_path(@software_product, @grouping, stage => "fourth")
      add_breadcrumb "Альтернатива #{@alternative.segment_full_name}", software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
    end

    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||= Grouping.find(params[:grouping_id])
    end

    def alternative
      @alternative ||= Alternative.find(params[:alternative_id])
    end

    def accomodation_wave_params
      params.require(:accomodation_wave).permit(:duration, :budget, :advertising_tools => [])
    end

    def stage
      params[:stage] || "fourth"
    end
end

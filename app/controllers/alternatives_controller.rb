class AlternativesController < ApplicationController
  helper_method :stage
  before_action :software_product, :grouping, :add_breadcrumbs

  layout 'software_product'

  def index
    @alternatives = @grouping.alternatives.sort_by(&:segment_full_name)
    add_breadcrumb "Список альтернатив"
  end

  def show
    @alternative = Alternative.find(params[:id])
    add_breadcrumb "Альтернатива #{@alternative.segment_full_name}"
  end

  def edit
    @alternative = Alternative.find(params[:id])
    add_breadcrumb "Редактирование альтернативы"
  end

  def update
    @alternative = Alternative.find(params[:id])
    @alternative.update(alternative_params)
    respond_with @software_product, @grouping, @alternative, :location =>  software_product_grouping_alternatives_path(@software_product, @grouping)
  end

  def upload_csv
    @alternative = Alternative.find(params[:id])
    if @alternative.update(alternative_params)
      path = "#{Rails.root}/public/#{@alternative.advertising_tool_csv.url}".split('?').first
      AdvertisingToolsImporter.new(path, @alternative.id).import
      redirect_to software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
    else
      render :show
    end
  end

  def destroy_advertising_tools
    @alternative = Alternative.find(params[:id])
    @alternative.advertising_tools.destroy_all
    redirect_to software_product_grouping_alternative_path(@software_product, @grouping, @alternative, :stage => "fourth")
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

    def alternative_params
      advertising_tools = ["advertising_tool_csv"]
      profit_array = %w(average_cost pessimistic_profit real_profit optimistic_profit)
      parameters_array = (1..10).inject([]){ |array,index|
        array.push("parameter#{index}" => [])
        array
      }
      params.require(:alternative).permit(profit_array + parameters_array + advertising_tools)
    end

    def stage
      params[:stage] || "third"
    end
end

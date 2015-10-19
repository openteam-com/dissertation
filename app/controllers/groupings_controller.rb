class GroupingsController < ApplicationController
  before_action :software_product, :add_breadcrumbs

  layout 'segments', :only => [:accomodation_waves, :alternatives_selection]

  def new
    add_breadcrumb "Новая группировка", new_software_product_grouping_path(@software_product)
    @grouping = @software_product.groupings.new
  end

  def create
    @grouping = @software_product.groupings.create(groupings_params)
    respond_with @grouping, :location =>  software_product_path(@software_product)
  end

  def edit
    @grouping = Grouping.find(params[:id])
    add_breadcrumb "Редактировать группировку",  edit_software_product_grouping_path(@software_product, @grouping)
  end

  def update
    @grouping = Grouping.find(params[:id])
    @grouping.update(groupings_params)
    respond_with @software_product, @grouping, :location =>  software_product_path(@software_product)
  end

  def destroy
    Grouping.find(params[:id]).destroy
    redirect_to software_product_path(@software_product)
  end

  def accomodation_waves
    @grouping = Grouping.find(params[:id])
    @problem = RglpkWrapper.new(@grouping.segments.joins(:alternatives).uniq, @software_product.workforce_directories, "max_profit", 1).solve
    @alternatives = Alternative.where(:step1 => true)
  end

  def alternatives_selection
    @grouping = Grouping.find(params[:id])
    if solution_step?(:first_step)
      problem = RglpkWrapper.new(@grouping.segments.joins(:alternatives).uniq,
                                 @software_product.workforce_directories,
                                 params[:solution][:first_step],
                                 1).solve

      @first_step_alternatives = @grouping.segments.flat_map(&:alternatives).sort_by(&:segment_full_name)
      @first_step_result = step_result(@first_step_alternatives.select{ |alternative| alternative.step1 == true })
    end

    if solution_step?(:second_step)
      problem = RglpkWrapper.new(@grouping.segments.joins(:alternatives).uniq,
                                 @software_product.workforce_directories,
                                 params[:solution][:second_step],
                                 2,
                                 additional_bounds_collection("first_step")).solve

      @second_step_alternatives = @grouping.segments.flat_map(&:alternatives).sort_by(&:segment_full_name)
      @second_step_result = step_result(@second_step_alternatives.select{ |alternative| alternative.step2 == true })
    end

    if solution_step?(:third_step)
      problem = RglpkWrapper.new(@grouping.segments.joins(:alternatives).uniq,
                                 @software_product.workforce_directories,
                                 params[:solution][:third_step],
                                 3,
                                 additional_bounds_collection("second_step")).solve

      @third_step_alternatives = @grouping.segments.flat_map(&:alternatives).sort_by(&:segment_full_name)
      @third_step_result = step_result(@third_step_alternatives.select{ |alternative| alternative.step3 == true })
    end

    if solution_step?(:fourth_step)
      problem = RglpkWrapper.new(@grouping.segments.joins(:alternatives).uniq,
                                 @software_product.workforce_directories,
                                 params[:solution][:fourth_step],
                                 4,
                                 additional_bounds_collection("third_step")).solve

      @fourth_step_alternatives = @grouping.segments.flat_map(&:alternatives).sort_by(&:segment_full_name)
      @fourth_step_result = step_result(@fourth_step_alternatives.select{ |alternative| alternative.step4 == true })
    end
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def groupings_params
      params.require(:grouping).permit(:title, :grouping_parameters_attributes => [:id, :grouping_field, :kind, :_destroy])
    end

    def add_breadcrumbs
      add_breadcrumb "Список программных продуктов", :software_products_path
      add_breadcrumb "Программный продукт '#{@software_product.title}'", software_product_path(@software_product)
    end

    def solution_step?(step)
      params[:solution].try(:[], step)
    end

    def step_result(alternatives)
      {
        "profit" => alternatives.sum(&:profit) - alternatives.map(&:fixed_costs).uniq.sum(),
        "attractiveness" => alternatives.sum(&:attractiveness),
        "investiton" => alternatives.sum(&:investiton),
        "segments" => alternatives.count
      }
    end

    def additional_bounds_collection(step)
      step_collection = ["first_step", "second_step", "third_step", "fourth_step"]
      step_collection = step_collection[0..step_collection.index(step)]
      step_collection.inject({}){ |hash, step|
        if solution_step?(step)
          step_value = params[:solution][:first_step]
          hash["#{step_value}_concession"] = [instance_variable_get("@#{step}_result")[step_value.gsub(/max_|min_/, "")], params[:solution]["#{step_value}_concession"]]
        end
        hash
      }
    end
end

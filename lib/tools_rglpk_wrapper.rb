class ToolsRglpkWrapper
  attr_accessor :problem, :rows, :cols, :alternative, :accomodation_wave

  def initialize(alternative, accomodation_wave)
    @alternative ||= alternative
    @accomodation_wave ||= accomodation_wave
    @problem ||= Rglpk::Problem.new
    @problem.obj.dir = Rglpk::GLP_MAX
    @rows ||= problem.add_rows(1 + grouped_tools_by_platform_quantity + advertising_tools.count + accomodation_wave.advertising_tools.count)
    @cols ||= problem.add_cols(advertising_tools.count)
  end

  def solve
    set_col_bounds
    set_row_bounds
    set_coef
    set_matrix
    problem.mip({:presolve => Rglpk::GLP_ON})

    advertising_tools.each_with_index do |tool, index|
      tool.update_column(:result, problem.cols[index].mip_val)
    end
  end

  private

    def grouped_tools_by_platform_quantity
      advertising_tools.group_by(&:platform_title).sum do |platform, tools|
        tools.group_by(&:tool_title).keys.count
      end
    end

    def advertising_tools
      @advertising_tools ||= alternative.advertising_tools.order(:platform_title).order(:showing_place).order(:tool_title)
    end

    def set_row_bounds
      row_index = 0
      rows[row_index].name = "restriction#{row_index}"
      rows[row_index].set_bounds(Rglpk::GLP_UP, 0, accomodation_wave.budget)
      row_index += 1

      advertising_tools.each do |tool|
        rows[row_index].set_bounds(Rglpk::GLP_UP, 0, tool.max_interval)
        row_index += 1
      end

      advertising_tools.group_by(&:platform_title).each do |platform, tools|
        tools.group_by(&:tool_title).each do |tool|
          rows[row_index].set_bounds(Rglpk::GLP_UP, 0, accomodation_wave.duration)
          row_index += 1
        end
      end

      accomodation_wave.advertising_tools.each do |tool|
        rows[row_index].set_bounds(Rglpk::GLP_LO, 1, 0)
        row_index += 1
      end
    end

    def set_coef
      problem.obj.coefs = advertising_tools.map{ |tool| (tool.ctr/100) * tool.average_show }
    end

    def set_col_bounds
      (0..(cols.count - 1)).each do |index|
        cols[index].name = "x#{index}"
        cols[index].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)
        cols[index].kind = Rglpk::GLP_IV
      end
    end

    def set_matrix
      coef_array = []
      coef_array << advertising_tools.pluck(:period_cost)

      (0..advertising_tools.count - 1).each do |index|
        coef_array << advertising_tools.map.with_index{ |tool, tool_index| tool_index == index ? tool.period : 0 }
      end

      advertising_tools.group_by(&:platform_title).each do |platform, tools|
        tools.group_by(&:tool_title).each do |tool_kind, tools_by_kind_and_platform|
          coef_array << advertising_tools.map{ |tool| tools_by_kind_and_platform.include?(tool) ? tool.period : 0 }
        end
      end

      accomodation_wave.advertising_tools.each do |ad_tool|
        coef_array << advertising_tools.map{ |tool| tool.tool_title == ad_tool ? 1 : 0 }
      end

      problem.set_matrix coef_array.flatten
    end
end

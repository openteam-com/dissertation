class RglpkWrapper
  attr_accessor :segments, :workforces, :problem, :rows, :cols, :step_number, :type, :additional_bounds

  def initialize(segments, workforces, type, step_number, additional_bounds = {})
    @segments ||= segments
    @workforces ||= workforces
    @step_number ||= step_number
    @type ||= type
    @additional_bounds ||= additional_bounds
    @problem ||= Rglpk::Problem.new
    @rows ||= problem.add_rows(segments.count + workforces.count + step_number - 1)
    @cols ||= problem.add_cols(segments.inject(0){ |sum,segment| sum+segment.alternatives.count })
  end


  def solve
    direction
    set_row_bounds
    set_col_bounds
    set_coef
    set_matrix
    problem.simplex

    alternatives.each_with_index do |alternative, index|
      alternative.update_column("step#{step_number}", !(problem.cols[index].get_prim.round.zero?))
    end
  end

  private

    def alternatives
      @alternatives ||= segments.flat_map(&:alternatives)
    end

    def direction
      if type.match(/max/)
        @problem.obj.dir = Rglpk::GLP_MAX
      else
        @problem.obj.dir = Rglpk::GLP_MIN
      end
    end

    def set_row_bounds
      workforces.each_with_index do |workforce, index|
        rows[index].name = "restriction#{index}"
        rows[index].set_bounds(Rglpk::GLP_UP, 0, workforce.available_resources - alternatives.flat_map(&:workforces).map(&:fixed_resources).uniq.sum)
      end
      (workforces.count..(rows.count-1-(step_number-1))).each do |index|
        rows[index].name = "restriction#{index}"
        rows[index].set_bounds(Rglpk::GLP_DB, 0, 1)
      end

      if additional_bounds.present?
        additional_index = rows.count-(step_number-1)
        additional_bounds.each do |key, value|
          if key.match(/max/)
            if key == "max_profit_concession"
              bound = value[0].to_f - value[1].to_f + alternatives.map(&:fixed_costs).uniq.sum()
            else
              bound = value[0].to_f - value[1].to_f
            end
            rows[additional_index].set_bounds(Rglpk::GLP_LO, bound, 0)
          else
            bound = value[0].to_f + value[1].to_f
            rows[additional_index].set_bounds(Rglpk::GLP_UP, 0, bound)
          end
          additional_index+=1
        end
      end
    end

    def set_col_bounds
      (0..(cols.count-1)).each do |index|
        cols[index].name = "x#{index}"
        cols[index].kind = Rglpk::GLP_BV
      end
    end

    def set_coef
      case type
      when "max_profit"
        problem.obj.coefs = alternatives.map{ |alternative| alternative.profit }
      when "max_attractiveness"
        problem.obj.coefs = alternatives.map{ |alternative| alternative.attractiveness }
      when "min_investition"
        problem.obj.coefs = alternatives.map{ |alternative| alternative.investiton }
      when "min_segments"
        problem.obj.coefs = alternatives.map{ |alternative| 1 }
      end
    end

    def set_matrix
      workforce_coef = workforces.inject([]){ |array, workforce|
        array << alternatives.map{ |alternative| alternative.workforce_values[workforce.specialists] }
      }

      segments_coef = segments.inject([]){ |array, segment|
        array << alternatives.map{ |alternative| segment.alternatives.include?(alternative) ? 1 : 0 }
      }

      additional_coef = []
      additional_bounds.each do |key, value|
        case key
        when "max_profit_concession"
          additional_coef << alternatives.map{ |alternative| alternative.profit }
        when "max_attractiveness_concession"
          additional_coef << alternatives.map{ |alternative| alternative.attractiveness }
        when "min_investition_concession"
          additional_coef << alternatives.map{ |alternative| alternative.investition }
        when "min_segments_concession"
          additional_coef << alternatives.map{ |alternative| 1 }
        end
      end

      problem.set_matrix (workforce_coef + segments_coef + additional_coef).flatten
    end
end

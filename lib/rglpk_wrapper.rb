class RglpkWrapper
  attr_accessor :segments, :software_product, :problem, :rows, :cols

  def initialize(segments, software_product)
    @segments ||= segments
    @software_product ||= software_product
    @problem ||= Rglpk::Problem.new
    @problem.obj.dir = Rglpk::GLP_MAX
    @rows ||= problem.add_rows(segments.count + software_product.workforce_directories.count)
    @cols ||= problem.add_cols(segments.inject(0){ |sum,segment| sum+segment.alternatives.count })
  end


  def solve
    set_row_bounds
    set_col_bounds
    set_coef
    set_matrix
    problem.simplex
    problem
    #(0..(cols.count-1)).map{ |a| p "#{cols[a].bounds} #{cols[a].kind}"}
  end

  private

    def alternatives
      @alternatives ||= segments.flat_map(&:alternatives)
    end

    def workforces
      workforces ||= software_product.workforce_directories
    end

    def set_row_bounds
      workforces.each_with_index do |workforce, index|
        rows[index].name = "restriction#{index}"
        rows[index].set_bounds(Rglpk::GLP_UP, 0, workforce.available_resources)
      end

      (workforces.count..(rows.count-1)).each do |index|
        rows[index].name = "restriction#{index}"
        rows[index].set_bounds(Rglpk::GLP_UP, 0, 1)
      end
    end

    def set_col_bounds
      (0..(cols.count-1)).each do |index|
        cols[index].name = "x#{index}"
        cols[index].kind = Rglpk::GLP_BV
        #cols[index].set_bounds(Rglpk::GLP_FX, 0, 1)
      end
    end

    def set_coef
      problem.obj.coefs = alternatives.map{ |alternative| alternative.profit - alternative.fixed_costs }
    end

    def set_matrix
      workforce_coef = workforces.inject([]){ |array, workforce|
        array << alternatives.map{ |alternative| alternative.workforce_values[workforce.specialists] }
      }

      segments_coef = segments.inject([]){ |array, segment|
        array << alternatives.map{ |alternative| segment.alternatives.include?(alternative) ? 1 : 0 }
      }
      problem.set_matrix (workforce_coef + segments_coef).flatten
    end
end

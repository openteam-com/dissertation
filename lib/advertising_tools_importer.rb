# encoding: utf-8

require 'csv'

class ToolRow
  attr_accessor :tool_row

  def initialize(row)
    @tool_row ||= row
  end

  def platform_title
    tool_row[0]
  end

  def tool_title
    tool_row[1]
  end

  def showing_place
    tool_row[2]
  end

  def price_model
    tool_row[3]
  end

  def period_cost
    tool_row[4]
  end

  def period
    tool_row[5]
  end

  def max_interval
    tool_row[6]
  end

  def average_show
    tool_row[7]
  end

  def ctr
    tool_row[8]
  end

  def click_cost
    tool_row[9]
  end
end

class AdvertisingToolsImporter
  attr_accessor :csv_path, :alternative

  def initialize(csv_path, alternative_id)
    @csv_path ||= csv_path
    @alternative ||= Alternative.find(alternative_id)
  end

  def import
    pb = ProgressBar.new csv.size
    csv.each do |record|
      import_record record
      pb.increment!
    end
  end

  private
    def csv
      @csv ||= CSV.read(csv_path, { :col_sep => ";" }).drop(1)
    end

    def import_record(record)
      tool_row = ToolRow.new(record)
      tool_params = {:platform_title => tool_row.platform_title,
        :tool_title => tool_row.tool_title,
        :showing_place => tool_row.showing_place,
        :price_model => tool_row.price_model,
        :period_cost => tool_row.period_cost,
        :period  => tool_row.period,
        :max_interval => tool_row.max_interval,
        :average_show => tool_row.average_show,
        :ctr => tool_row.ctr,
        :click_cost => tool_row.click_cost
      }
      alternative.advertising_tools.create tool_params
    end

#  platform_title :string
#  tool_title     :string
#  showing_place  :string
#  price_model    :string
#  period_cost    :float
#  period         :integer
#  max_interval   :integer
#  average_show   :float
#  ctr            :float
end


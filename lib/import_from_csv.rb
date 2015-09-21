# encoding: utf-8

require 'csv'

class ImportFromCsv
  attr_accessor :csv_path, :software_product_id

  def initialize(csv_path, software_product_id)
    @csv_path ||= csv_path
    @software_product_id ||= software_product_id
  end

  def import
    bar = ProgressBar.new csv_size
    prepare_hash.each do |record|
      import_record record
      bar.increment!
    end
  end

  def csv_size
    @csv_size ||= prepare_hash.size
  end

  def prepare_hash
    csv_data = CSV.read csv_path
    headers = csv_data.shift.map {|i| i.to_s }.reject{ |header| header.blank? }
    @prepare_hash ||= csv_data.map {|row| row.map {|cell| cell.to_s.strip } }
    @prepare_hash.map {|row| Hash[*headers.zip(row).flatten] }
  end

  def import_record(record)
    software_product.research_items.create(:data => OpenStruct.new(record))
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(software_product_id)
    end
end

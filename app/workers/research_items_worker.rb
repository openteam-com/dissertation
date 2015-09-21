class ResearchItemsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(csv_path, software_product_id)
    importer = ImportFromCsv.new(csv_path, software_product_id)
    importer.prepare_hash.each_with_index do |record, index|
      importer.import_record(record)
      at index_to_percent(importer.csv_size, index)
    end
  end

  private
  def index_to_percent(total, current)
    current*100/(total-1)
  end
end

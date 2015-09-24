class DestroyResearchItems < ResearchItemsWorker
  def perform(software_product_id)
    software_product = SoftwareProduct.find(software_product_id)
    software_product.research_items.each_with_index do |item, index|
      at index_to_percent(software_product.research_items.size - 1 ,index)
      item.destroy
    end
  end
end

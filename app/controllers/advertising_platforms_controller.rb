class AdvertisingPlatformsController < ApplicationController
  before_action :software_product, :grouping, :alternative, :accomodation_wave

  layout 'segments'

  def edit
    @advertising_platform = AdvertisingPlatform.find(params[:id])
  end

  def update
    @advertising_platform = AdvertisingPlatform.find(params[:id])
    @advertising_platform.update(advertising_platform_params)
    respond_with @software_product, @grouping, @alternative, @accomodation_wave, @advertising_platform, :location =>  accomodation_waves_software_product_grouping_path(@software_product, @grouping)
  end

  private
    def software_product
      @software_product ||= SoftwareProduct.find(params[:software_product_id])
    end

    def grouping
      @grouping ||= Grouping.find(params[:grouping_id])
    end

    def alternative
      @alternative ||= Alternative.find(params[:alternative_id])
    end

    def accomodation_wave
      @accomodation_wave ||= AccomodationWave.find(params[:accomodation_wafe_id])
    end

    def advertising_platform_params
      params.require(:advertising_platform).permit(:title, :url, :advertising_places_attributes => [:id, :views_quantity, :price_type, :price, :_destroy])
    end
end

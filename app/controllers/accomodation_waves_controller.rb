class AccomodationWavesController < ApplicationController
  before_action :software_product, :grouping, :alternative

  layout 'segments'

  def new
    @accomodation_wave = AccomodationWave.new
  end

  def create
    @accomodation_wave = @alternative.accomodation_waves.create(accomodation_wave_params)
    respond_with @accomodation_wave, :location =>  accomodation_waves_software_product_grouping_path(@software_product, @grouping)
  end

  def edit
    @accomodation_wave = AccomodationWave.find(params[:id])
  end

  def update
    @accomodation_wave = AccomodationWave.find(params[:id])
    @accomodation_wave.update(accomodation_wave_params)
    respond_with @software_product, @grouping, @alternative, @accomodation_wave, :location =>  accomodation_waves_software_product_grouping_path(@software_product, @grouping)
  end

  def destroy
    AccomodationWave.find(params[:id]).destroy
    redirect_to accomodation_waves_software_product_grouping_path(@software_product, @grouping)
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

    def accomodation_wave_params
      params.require(:accomodation_wave).permit(:duration, :advertising_platforms_attributes => [:id, :title, :url, :_destroy])
    end
end

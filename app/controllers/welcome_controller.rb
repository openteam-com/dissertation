class WelcomeController < ApplicationController
  def index
    redirect_to software_products_path
  end
end

class Api::V1::PlantsController < Api::V1::BaseController
  require 'open-uri'
  def index
    if params[:query]
      query = URI.escape(params[:query])
    else
      query = "oak"
    end
    render json: TrefleApiService.new(query).search_plants
  end
end

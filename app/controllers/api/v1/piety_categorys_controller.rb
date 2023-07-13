class Api::V1::PietyCategorysController < ApplicationController
  def index
    piety_categorys = PietyCategory.all
    render json: { data: piety_categorys.as_json }
  end
end

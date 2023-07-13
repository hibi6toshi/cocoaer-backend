class Api::V1::PietyTargetsController < ApplicationController
  def index
    piety_targets = PietyTarget.all
    render json: { data: piety_targets.as_json }
  end
end

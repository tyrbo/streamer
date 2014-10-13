class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    render json: Game.includes(:contestants).order('date_time DESC')
  end
end

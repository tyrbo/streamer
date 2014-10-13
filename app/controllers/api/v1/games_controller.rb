class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    respond_with Game.all
  end
end

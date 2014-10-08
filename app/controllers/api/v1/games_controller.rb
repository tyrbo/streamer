class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    respond_with []
  end

  def show
    respond_with {}
  end
end

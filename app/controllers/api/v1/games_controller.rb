class Api::V1::GamesController < ApplicationController
  respond_to :json
  before_action :check_user, only: [:subscribe]

  def index
    render json: Game.includes(:contestants).order('date_time DESC')
  end

  def subscribe
    game = Game.find(params[:id])

    if game
      result = SubscriptionProcessor.new(game, current_user).run

      render json: { success: true, status: result, error: nil }, status: 201
    else
      render json: { success: false, error: 'not found' }, status: 404
    end
  end

  private

  def check_user
    return if current_user

    render json: { success: false, error: 'auth' }, status: 401
  end

end

class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    if current_user && is_current_user?
      render json: User.includes(:games).find(params['id'])
    end
  end

  private

  def is_current_user?
    current_user.id == params['id'].to_i
  end
end

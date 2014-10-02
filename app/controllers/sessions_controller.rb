class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(auth_hash)
    self.current_user = @user
    redirect_to root_path
  end

  private

  def auth_hash
    auth = request.env['omniauth.auth']

    {
      display_name: auth['info']['display_name'],
      name: auth['info']['name'],
      email: auth['info']['email'],
      bio: auth['info']['bio'],
      logo: auth['info']['logo'],
      type: auth['info']['type']
    }
  end
end

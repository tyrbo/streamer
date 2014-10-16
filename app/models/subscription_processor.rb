class SubscriptionProcessor
  attr_reader :game, :user

  def initialize(game, user)
    @game = game
    @user = user
  end

  def run
    if user.games.include?(game)
      user.games.delete(game)
      :unsubscribed
    else
      user.games << game
      :subscribed
    end
  end
end

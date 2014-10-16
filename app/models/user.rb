class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :games, through: :subscriptions

  self.inheritance_column = nil

  def self.with_game_start
    User.all
  end

  def self.with_game_end
    User.all
  end
end

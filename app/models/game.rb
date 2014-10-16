class Game < ActiveRecord::Base
  has_many :contestants, through: :matches
  has_many :matches

  has_many :users, through: :subscriptions
  has_many :subscriptions

  def self.starting_soon(time)
    where('date_time >= ? AND date_time <= ?', time - 5.minutes, time + 5.minutes).first
  end
end

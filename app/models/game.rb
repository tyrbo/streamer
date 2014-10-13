class Game < ActiveRecord::Base
  has_many :contestants, through: :matches
  has_many :matches
end

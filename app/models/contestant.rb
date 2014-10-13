class Contestant < ActiveRecord::Base
  has_many :games, through: :matches
  has_many :matches
end

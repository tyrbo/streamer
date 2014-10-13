class GameSerializer < ActiveModel::Serializer
  attributes :id, :match_name, :winner_id, :live, :finished, :max_games
  has_many :contestants
end

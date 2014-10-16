class UserSerializer < ActiveModel::Serializer
  attributes :id, :phone_number
  has_many :games
end

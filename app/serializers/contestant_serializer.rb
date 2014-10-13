class ContestantSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo, :acronym, :wins, :losses, :team_id
end

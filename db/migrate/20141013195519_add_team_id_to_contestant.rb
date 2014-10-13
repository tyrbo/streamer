class AddTeamIdToContestant < ActiveRecord::Migration
  def change
    add_column :contestants, :team_id, :integer
  end
end

class AddThingsToGames < ActiveRecord::Migration
  def change
    add_column :games, :match_name, :string
    add_column :games, :winner_id, :integer
    add_column :games, :match_id, :integer
    add_column :games, :league_id, :integer
    add_column :games, :max_games, :integer
    add_column :games, :finished, :boolean
    add_column :games, :date_time, :datetime

    add_index :games, :match_id
    add_index :games, :league_id
    add_index :games, :date_time
  end
end

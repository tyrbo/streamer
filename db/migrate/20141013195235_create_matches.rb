class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :game_id
      t.integer :contestant_id
    end
  end
end

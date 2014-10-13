class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.string :name
      t.string :logo
      t.string :acronym
      t.integer :wins
      t.integer :losses
    end
  end
end

class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :live
    end
  end
end

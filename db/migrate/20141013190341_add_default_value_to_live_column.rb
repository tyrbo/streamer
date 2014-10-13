class AddDefaultValueToLiveColumn < ActiveRecord::Migration
  def change
    change_column :games, :live, :boolean, default: false
  end
end

class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :name
      t.string :email
      t.string :bio
      t.string :logo
      t.string :type
    end
  end
end

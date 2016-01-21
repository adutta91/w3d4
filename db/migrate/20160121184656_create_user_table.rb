class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, unique: true
      t.timestamp
    end

  end
end

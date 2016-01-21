class AddColumnTimestamps < ActiveRecord::Migration
  def change
    add_column(:users, :created_at, :datetime )
    add_column(:users, :updated_at, :datetime )
    change_column(:users, :user_name, :string, null: false, uniqueness: true)
  end
end

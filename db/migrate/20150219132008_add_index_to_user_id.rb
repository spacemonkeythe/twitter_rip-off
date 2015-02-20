class AddIndexToUserId < ActiveRecord::Migration
  def change
    add_index :tweets, [:user_id, :created_at], unique: true
  end
end

class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :user, foreign_key: true
      t.references :friend

      t.timestamps
    end
    add_index :friend_requests, [:user_id, :friend_id], unique: true
  end
end

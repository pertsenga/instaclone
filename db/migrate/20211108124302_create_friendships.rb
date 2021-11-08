class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :friend, null: false, foreign_key: {to_table: :users}
      t.datetime :accepted_at, null: true
      t.datetime :rejected_at, null: true

      t.timestamps
    end
  end
end

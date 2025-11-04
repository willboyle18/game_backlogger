class AddUniqueIndexToBacklogItems < ActiveRecord::Migration[8.0]
  def change
    add_index :backlog_items, [ :game_id, :user_id ], unique: true
  end
end

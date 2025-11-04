class FixBacklogItemsCompositeIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :backlog_items, name: :index_backlog_items_on_game_id_and_user_id
    add_index    :backlog_items, [ :user_id, :game_id ], unique: true
  end
end

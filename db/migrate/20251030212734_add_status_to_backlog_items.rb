class AddStatusToBacklogItems < ActiveRecord::Migration[8.0]
  def change
    add_column :backlog_items, :status, :integer, default: 0, null: false
  end
end

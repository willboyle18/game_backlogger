class CreateBacklogItems < ActiveRecord::Migration[8.0]
  def change
    create_table :backlog_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.timestamps
    end
  end
end

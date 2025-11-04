class ConvertToIgdbData < ActiveRecord::Migration[8.0]
  def change
    change_table :games do |t|
      t.integer :igdb_id unless column_exists?(:games, :igdb_id)
      t.string :name unless column_exists?(:games, :name)
      t.string :slug unless column_exists?(:games, :slug)
      t.text :summary unless column_exists?(:games, :summary)
      t.float :rating unless column_exists?(:games, :rating)
      t.string :cover_image_id unless column_exists?(:games, :cover_image_id)
      t.bigint :first_release_date unless column_exists?(:games, :first_release_date)

      unless column_exists?(:games, :platform_ids)
        t.integer :platform_ids, array: true, default: [], null: false
      end
    end
    add_index :games, :igdb_id, unique: true unless index_exists?(:games, :igdb_id, unique: true)
    add_index :games, :name unless index_exists?(:games, :name)
    add_index :games, :slug unless index_exists?(:games, :slug)
    add_index :games, :platform_ids, using: :gin unless index_exists?(:games, :platform_ids)

    change_column_null :games, :igdb_id, false
    change_column_null :games, :name,    false
  end
end

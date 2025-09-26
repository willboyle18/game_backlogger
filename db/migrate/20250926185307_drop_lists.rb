class DropLists < ActiveRecord::Migration[8.0]
  def change
    drop_table :lists do |t|
      t.string :name
      t.timestamps
    end
  end
end

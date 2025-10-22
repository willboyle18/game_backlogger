class AddExplicitForeignKeyToUser < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :friends, :users, column: :user_id
  end
end

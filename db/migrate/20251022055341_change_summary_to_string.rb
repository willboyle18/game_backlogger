class ChangeSummaryToString < ActiveRecord::Migration[8.0]
  def change
    change_column :games, :summary, :string
  end
end

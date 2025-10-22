class ChangeSummaryBackToText < ActiveRecord::Migration[8.0]
  def change
    change_column :games, :summary, :text
  end
end

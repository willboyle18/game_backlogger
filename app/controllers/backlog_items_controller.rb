class BacklogItemsController < ApplicationController
  before_action :require_authentication
  def index
    @backlog_items = Current.user.backlog_items.includes(:game).order(created_at: :desc)
  end

  def create
    @backlog_item = Current.user.backlog_items.build(backlog_item_params)
    puts "hello"
    if @backlog_item.save
      redirect_back fallback_location: backlog_items_path, notice: "Added to your backlog"
    else
      redirect_back fallback_location: backlog_items_path, alert: "Unable to add to your backlog"
    end
  end

  def update
  end

  def destroy
  end

  private

  def backlog_item_params
    params.require(:backlog_item).permit(:game_id)
  end
end

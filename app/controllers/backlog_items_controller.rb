class BacklogItemsController < ApplicationController
  def index
    @backlog_items = current_user.backlog_items.includes(:game).order(created_at: :desc)
  end

  def create
  end

  def update
  end

  def destroy
  end
end

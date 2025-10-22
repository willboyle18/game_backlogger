class BacklogItemsController < ApplicationController
  before_action :require_authentication,
  def index
    @backlog_items = Current.user.backlog_items.includes(:game).order(created_at: :desc)
  end

  def create
    igdb_id = params.require(:igdb_id).to_i
    game = Game.find_by(igdb_id:) || insert_game_from_igdb!(igdb_id)

    begin
      item = Current.user.backlog_items.find_or_create_by!(game: game)
      flash[:notice] = "Game successfully added to backlog"
    rescue ActiveRecord::RecordNotUnique
      # Unique index on [user_id, game_id]
      flash[:alert] = "Already in backlog"
    end

    redirect_back fallback_location: igdb_search_path(q: params[:q])
  end

  def update
  end


  def destroy
    item = Current.user.backlog_items.find(params[:id])
    item.destroy!
    redirect_back fallback_location: backlog_items_path, notice: "Removed from your backlog"
  end

  private

  def backlog_item_params
    params.require(:backlog_item).permit(:game_id)
  end

  def insert_game_from_igdb!(igdb_id)
    Game.transaction(requires_new: true) do
      Game.find_or_create_by!(igdb_id: igdb_id) do |g|
        data = IgdbSearch.new.game_by_id(igdb_id) or raise "IGDB not found"
        g.name = data["name"]
        g.slug = data["slug"]
        g.first_release_date = data["first_release_date"]
        g.cover_image_id = data.dig("cover","image_id")
        g.rating = data["total_rating"]
        g.summary = data["summary"]
        g.platform_ids = Array(data["platforms"]).map { _1["id"] }
      end
    end
  end
end

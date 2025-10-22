class GamesController < ApplicationController
  before_action :require_authentication
  def index
    @games = Game.order(created_at: :desc)
  end

  def new
    @game = Game.new
  end
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, notice: "Game created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    igdb_id = params.require(:igdb_id).to_i
    @game = Game.find_by(igdb_id:) || insert_game_from_igdb!(igdb_id)
    @platform_names = get_platforms(@game.platform_ids)
  end

  private

  def get_platforms(platform_ids)
    ids = Array(platform_ids).compact
    return [] if ids.empty?

    plats = IgdbSearch.new.platforms_by_ids(ids, fields: %w[id name abbreviation])
    by_id = plats.to_h { |p| [p["id"], (p["name"].presence).to_s] }
    ids.filter_map { |id| by_id[id].presence }
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

  def game_params
    params.require(:game).permit(:name)
  end
end
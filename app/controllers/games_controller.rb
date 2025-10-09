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
    @game = Game.find(params[:id])
    @backlog_item = Current.user.backlog_items.find_by(game_id: @game.id) ||
                    Current.user.backlog_items.build(game: @game)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
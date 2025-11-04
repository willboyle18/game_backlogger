class ReviewsController < ApplicationController
  before_action :set_game

  def create
    @review = @game.reviews.new(review_params)
    @review.user = Current.user

    if @review.save
      redirect_to game_path(@game.igdb_id), notice: "Review added successfully!"
    else
      redirect_to game_path(@game.igdb_id), alert: "Failed to add review."
    end
  end

  def show
    @review = Review.find(params[:id])
    @comments = @review.comments.order(created_at: :desc)
  end

  private

  def set_game
    @game = Game.find_by(igdb_id: params[:game_igdb_id])
  end

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end

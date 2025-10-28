class FriendsController < ApplicationController
  before_action :require_authentication


  def index
    @current_friends = Current.user.all_friends

    @outgoing_requests = Current.user.outgoing_requests

    @incoming_requests = Current.user.incoming_requests
  end

  def search
    query = params[:q].to_s.strip
    @users = User.where("email_address ILIKE ?", "%#{query}%")
                 .where.not(id: Current.user.id)

    refresh_friend_lists

    render :index
  end

  def create
    friend_id = params[:friend_id]

    begin
      Friend.create!(
        user_id: Current.user.id,
        friend_id: friend_id,
        status: "pending"
      )
    rescue ActiveRecord::RecordNotUnique
      puts "friend record already exists"
    end

    refresh_friend_lists

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to friends_path }
    end
  end

  def show
    friendship = Friend.find(params[:id])


    if Current.user.id == friendship.friend_id
      friend_id = friendship.user_id
    else
      friend_id = friendship.friend_id
    end
    @friend = User.find(friend_id)
    @backlog_items = @friend.backlog_items.includes(:game).order(created_at: :desc)
  end

  def update
    friend = Friend.find(params[:id])

    friend.update(status: "accepted")

    refresh_friend_lists

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to friends_path }
    end

  end

  def destroy
    friend = Friend.find(params[:id])
    friend.destroy

    refresh_friend_lists

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to friends_path }
    end
  end

  private

  def refresh_friend_lists
    @current_friends = Current.user.all_friends
    @outgoing_requests = Current.user.outgoing_requests
    @incoming_requests = Current.user.incoming_requests
  end
end
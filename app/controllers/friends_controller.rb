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

    @current_friends   = Current.user.all_friends
    @incoming_requests = Current.user.incoming_requests
    @outgoing_requests = Current.user.outgoing_requests

    render :index
  end

  def create

  end

  def update

  end

  def destroy

  end
end
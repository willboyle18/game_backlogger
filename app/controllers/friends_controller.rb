class FriendsController < ApplicationController
  before_action :require_authentication


  def index
    @current_friends = Current.user.all_friends

    @outgoing_requests = Current.user.outgoing_requests

    @incoming_requests = Current.user.incoming_requests
  end

  def search

  end

  def create

  end

  def update

  end

  def destroy

  end
end
class IgdbSearchesController < ApplicationController
  before_action :require_authentication

  def show
    search = ::IgdbSearch.new
    @query = params[:q].to_s.strip
    @results = @query.present? ? search.search_games(@query, limit: 3) : []
  end
end
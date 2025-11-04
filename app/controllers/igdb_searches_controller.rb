class IgdbSearchesController < ApplicationController
  before_action :require_authentication

  def show
    search = ::IgdbSearch.new
    @query = params[:q].to_s.strip
    @page = params[:page].to_i
    limit = 20
    offset = @page * limit

    @results = @query.present? ? search.search_games(@query, limit:, offset:) : []
  end
end

require "net/https"
require "json"
require "uri"

class IgdbSearch
  BASE = "https://api.igdb.com/v4".freeze

  def initialize
    @client_id = ENV["TWITCH_CLIENT_ID"]
    @access_token = ENV["IGDB_ACCESS_TOKEN"]
  end

  def search_games(query, limit: 10)
    return [] if query.to_s.strip.empty?


    uri = URI("#{BASE}/games")
    req = Net::HTTP::Post.new(uri)
    req["Client-ID"] = @client_id
    req["Authorization"] = "Bearer #{@access_token}"
    req["Accept"]        = "application/json"
    req["Content-Type"]  = "text/plain"
    req.body = <<~APQ
      fields name, first_release_date, cover.url, platforms.name, genres.name, slug;
      search "#{query}";
      limit #{limit};
    APQ

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      res = http.request(req)
      res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []
    end
  end
end
require "net/https"
require "json"
require "uri"

class IgdbSearch
  BASE = "https://api.igdb.com/v4".freeze

  DEFAULT_FIELDS = %w[
    id
    name
    slug
    first_release_date
    cover.image_id
    platforms.id
    total_rating
    summary
  ].freeze

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
      fields id, name, first_release_date, cover.url, platforms.name, genres.name, slug, summary;
      search "#{query}";
      limit #{limit};
    APQ

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      res = http.request(req)
      res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : []
    end
  end

  def game_by_id(id, fields: DEFAULT_FIELDS)
    id = Integer(id)
    fields_list = Array(fields).join(", ")

    uri = URI("#{BASE}/games")
    req = Net::HTTP::Post.new(uri)
    req["Client-ID"]     = @client_id
    req["Authorization"] = "Bearer #{@access_token}"
    req["Accept"]        = "application/json"
    req["Content-Type"]  = "text/plain"
    req.body = <<~APQ
      fields #{fields_list};
      where id = #{id};
      limit 1;
    APQ

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      res = http.request(req)
      return nil unless res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body).first
    end
  end

  def platforms_by_ids(ids, fields: 'id, name')
    ids = Array(ids).compact.map { |x| Integer(x) rescue nil }.compact.uniq
    return [] if ids.empty?

    fields_list = Array(fields).join(", ")
    uri = URI("#{BASE}/platforms")
    req = Net::HTTP::Post.new(uri)
    req["Client-ID"]     = @client_id
    req["Authorization"] = "Bearer #{@access_token}"
    req["Accept"]        = "application/json"
    req["Content-Type"]  = "text/plain"
    req.body = <<~APQ
      fields #{fields_list};
      where id = (#{ids.join(",")});
      limit #{ids.size};
    APQ

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      res = http.request(req)
      return nil unless res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    end
  end

end
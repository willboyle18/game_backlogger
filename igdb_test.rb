require "dotenv/load"
require 'net/https'
require 'uri'

client_id = ENV.fetch("TWITCH_CLIENT_ID")
igdb_access_token = ENV.fetch("IGDB_ACCESS_TOKEN")

uri = URI("https://api.igdb.com/v4/games")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

headers = {
  'Client-ID' => client_id,
  'Authorization' => 'Bearer ' + igdb_access_token
}

request = Net::HTTP::Post.new(uri, headers)
request.body = 'fields name,first_release_date,cover.url; limit 5;'

response = http.request(request)
puts response.body

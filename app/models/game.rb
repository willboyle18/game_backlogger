class Game < ApplicationRecord
  has_many :backlog_items, dependent: :destroy
  has_many :users, through: :backlog_items

  validates :name, presence: true
  validates :igdb_id, presence: true, uniqueness: true

  def release_year
    return nil unless first_release_date
    ts = first_release_date
    ts = ts / 1000 if ts > 2_000_000_000
    Time.at(ts).utc.year
  end

  def cover_url(size: "t_cover_big")
    return nil if cover_image_id.blank?
    "https://images.igdb.com/igdb/image/upload/#{size}/#{cover_image_id}.jpg"
  end
end
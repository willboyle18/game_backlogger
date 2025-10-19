namespace :wipe do
  desc "Wipe IGDB-related data (dev/test only). Deletes backlog_items + games."
  task igdb: :environment do
    abort "Refusing to run outside dev/test (RAILS_ENV=#{Rails.env})." unless Rails.env.development? || Rails.env.test?

    confirmed = ENV["CONFIRM"] == "yes"
    unless confirmed
      puts "About to DELETE all rows from: backlog_items, games"
      puts "If you're sure, re-run with: CONFIRM=yes bin/rails wipe:igdb"
      abort
    end

    ActiveRecord::Base.transaction do
      BacklogItem.delete_all
      Game.delete_all
    end

    puts "✓ Wiped backlog_items and games."
  end
end


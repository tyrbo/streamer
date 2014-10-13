class GameScheduler
  attr_reader :conn
  # Hit Riot Games JSON endpoint
  # Check each object in array for contained matches
  # Add matches ("game" objects) to database.
  # Download team logos if not exist, will need to resize (?)

  def initialize
    @conn = Faraday.new(url: 'http://na.lolesports.com') do |f|
      f.request :url_encoded
      f.response :logger
      f.adapter Faraday.default_adapter
    end
  end
end

class GameScheduler
  attr_reader :conn
  # Hit Riot Games JSON endpoint
  # Check each object in array for contained matches
  # Add matches ("game" objects) to database.
  # Download team logos if not exist, will need to resize (?) - 134x134 currently

  def initialize
    @conn = Faraday.new(url: 'http://na.lolesports.com') do |f|
      f.request :url_encoded
      f.response :logger
      f.adapter Faraday.default_adapter
    end
  end

  def build_games
    response = fetch(method: 'all', tournament: '175,177,178,179,176', expand_matches: 1)
    response.each do |block|
      if block['matches'].count > 0
        block['matches'].each do |match|
          build_game(match, block['leagueId'])
        end
      end
    end
  end

  def build_game(match, league_id)
    game = Game.find_or_initialize_by(match_id: match['matchId'])

    game.date_time = match['dateTime']
    game.match_name = match['matchName']
    game.winner_id = match['winnerId']
    game.match_id = match['matchId']
    game.max_games = match['maxGames']
    game.finished = (match['isFinished'] == '0' ? false : true) || false
    game.league_id = league_id

    game.save

    build_contestants(match['contestants']['blue'], match['contestants']['red'], game)
  end

  def build_contestants(blue, red, game)
    game.contestants << build_contestant(blue)
    game.contestants << build_contestant(red)
  end

  def build_contestant(team)
    contestant = Contestant.find_or_initialize_by(team_id: team['id'])
    contestant.team_id = team['id']
    contestant.name = team['name']
    contestant.logo = team['logoURL']
    contestant.acronym = team['acronym']
    contestant.wins = team['wins']
    contestant.losses = team['losses']
    contestant.save
    contestant
  end

  def fetch(params)
    built_params = build_params(params)
    response = conn.get "/api/programming.json#{built_params}"
    JSON.parse(response.body)
  end

  def build_params(params)
    resp = ''

    params.each do |key, value|
      if resp.empty?
        resp << "?"
      else
        resp << "&"
      end
      resp << "parameters[#{key.to_s}]=#{value.to_s}"
    end

    resp
  end
end

require 'redis'

class GameWatcher
  def self.wait_for_game
    loop do
      game = Game.starting_soon(Time.now.utc)

      if game
        GameWatcher.new(game).start
      end

      sleep(5)
    end
  end

  attr_reader :game, :metadata, :stats, :stats_conn, :redis

  def initialize(game)
    @game = game

    build_connections
  end


  def build_connections
    @stats_conn = Faraday.new(url: 'http://localhost:1337') do |f|
      f.request :url_encoded
      f.response :logger
      f.adapter Faraday.default_adapter
    end

    @redis = Redis.new
  end

  def start
    loop do
      if get_game_stats
        begin
          Pusher.trigger('game', 'stats-event', stats)
          StatsNotifierWorker.perform_async(game.id, stats)
          redis.set('lol-game-stats', stats)

          if finished?
            break
          end
        rescue Pusher::Error => e
        end
      end

      sleep(5)
    end
  end

  def get_game_stats
    begin
      response = JSON.parse(stats_conn.get('/').body)
      @stats = response
      true
    rescue
      false
    end
  end

  def finished?
    stats.all? { |x| x['players'].none? } && stats.any? { |x| x['winner'] }
  end
end

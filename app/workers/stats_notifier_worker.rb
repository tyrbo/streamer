require 'redis'

class StatsNotifierWorker
  include Sidekiq::Worker

  attr_reader :game, :redis, :client, :stats, :last_stats

  def perform(game, stats)
    @game = Game.find(game)
    @redis = Redis.new
    @stats = stats
    @client = Twilio::REST::Client.new
    @last_stats = redis.get('lol-game-stats')

    execute
  end

  def execute
    if no_players && no_winner
      notify_game_start
    end

    if no_players && winner
      notify_game_end
    end
  end

  def notify_game_start
    match_name = game.match_name
    User.with_game_start.each do |user|
      client.messages.create(
        from: '+17204082298',
        to: user.phone_number,
        body: "#{match_name} has just started."
      )
    end
  end

  def no_players
    stats.all? { |x| x['players'].none? }
  end

  def no_winner
    stats.all? { |x| !x['winner'] }
  end

  def notify_game_end
    match_name = game.match_name
    User.with_game_end.each do |user|
      client.messages.create(
        from: '+17204082298',
        to: user.phone_number,
        body: "#{match_name} has ended. The winner was #{winner}."
      )
    end
  end

  def winner
    winner = stats.find({}) { |x| x['winner'] }
    winner['name']
  end
end

require 'rails_helper'

describe GameScheduler, type: :model do
  let(:g) { GameScheduler.new }

  it 'creates a Faraday Connection instance' do
    expect(g.conn).to be_instance_of(Faraday::Connection)
  end

  it 'builds a url from parameters' do
    params = { method: 'all', tournament: '175,177,178,179,176', expand_matches: 1 }

    expect(g.build_params(params)).to eq '?parameters[method]=all&parameters[tournament]=175,177,178,179,176&parameters[expand_matches]=1'
  end

  it 'creates new games from returned match information' do
    VCR.use_cassette('schedule') do
      expect(Game.count).to eq 0
      g.build_games
      expect(Game.count).to eq 57
    end
  end
end

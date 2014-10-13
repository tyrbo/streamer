require 'rails_helper'

describe GameScheduler, type: :model do
  it 'creates a Faraday Connection instance' do
    g = GameScheduler.new
    expect(g.conn).to be_instance_of(Faraday::Connection)
  end
end

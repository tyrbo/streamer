App.LiveGame = Ember.Object.extend({
  teams: [],

  hasPlayers: function() {
    return this.get('teams')[0].players.length > 0 || this.get('teams')[1].players.length > 0
  }.property('teams'),

  hasWinner: function() {
    return this.get('teams')[0].winner || this.get('teams')[1].winner
  }.property('teams'),

  winner: function() {
    if (this.get('teams')[0].winner) {
      return this.get('teams')[0].name
    } else if (this.get('teams')[1].winner) {
      return this.get('teams')[1].name
    }
  }.property('teams')
});

App.GamesRoute = Ember.Route.extend({
  model: function() {
    var self = this;
    setInterval(function() { self.reload(); }, 5000)
    return this.get('store').find('game');
  },

  reload: function() {
    var data = this.get('store').find('game');
    this.set('content', data);
  },
  
  setupController: function(controller, model) {
    controller.set('content', model);
    controller.set('liveGame', App.LiveGame.create());
  }
});

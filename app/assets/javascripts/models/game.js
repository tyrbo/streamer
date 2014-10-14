var attr = DS.attr;

App.GameSerializer = DS.RESTSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    contestants: { embedded: 'always' }
  }
});

App.Game = DS.Model.extend({
  match_name: attr('string'),
  max_games: attr('string'),
  winner_id: attr('string'),
  live: attr('boolean'),
  finished: attr('boolean'),
  contestants: DS.hasMany('contestant'),
  contestant_array: function() {
    return this.get('contestants').toArray();
  }.property('contestants')
});

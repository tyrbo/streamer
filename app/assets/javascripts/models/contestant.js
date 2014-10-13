var attr = DS.attr;

App.Contestant = DS.Model.extend({
  name: attr(),
  logo: attr(),
  acronym: attr(),
  wins: attr(),
  losses: attr(),
  team_id: attr()
});

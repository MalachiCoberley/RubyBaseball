class Team
  LAST_NAMES = ["Sylvester", "McCormick", "Egan", "Brock", "Davies", "Matos", "Dominguez", "Faulk", "Mcnair", "Noble", "Waller", "Blackmon", "Carpenter", "Hodges", "Moreno", "Crowe", "Spencer", "McMullen", "Hammond", "Rhodes"]
  FIRST_INITIALS = ("A".."Z").to_a

  attr_reader :players, :team_name

  def self.generate_team(roster_size)
    Array.new(size) {FIRST_INITIALS.sample + ". " + LAST_NAMES.sample}
  end

  def initialize(team_name, roster_size)
    @team_name = team_name
    # players will receive an array of TeamPlayers names: "FirstInitial LastName"
    @players = Team.generate_team(roster_size)
  end

end

new_team = Team.new("Pirates", 6)
p new_team.players
p new_team.team_name

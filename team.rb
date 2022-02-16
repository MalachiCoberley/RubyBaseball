class Team
  FIRST_INITIALS = ("A".."Z").to_a
  LAST_NAMES = ["Sylvester", "McCormick", "Egan", "Brock", "Davies", "Matos", "Dominguez", "Faulk", "Mcnair", "Noble", "Waller", "Blackmon", "Carpenter", "Hodges", "Moreno", "Crowe", "Spencer", "McMullen", "Hammond", "Rhodes"]
  TEAM_NAMES = ["Pirates", "Tigers", "Chargers", "Eagles", "Bears", "Blue Jays", "Robins", "Cardinals", "Panthers", "Falcons", "Hawks", "Trains"]
  POSITIONS = ["P", "C", "FB", "SB", "SS", "TB", "LF", "CF", "RF"]

  attr_reader :lineup, :name


  def self.generate_team()
    team = Array.new(9) {Hash.new()}
    9.times do |num|
      team[num][:position] = POSITIONS[num]
      team[num][:name] = FIRST_INITIALS.sample + ". " + LAST_NAMES.sample
    end
    team.shuffle!
  end

  def initialize()
    @name = TEAM_NAMES.sample
    @lineup = Team.generate_team()
    @lineupPosition = 0
  end

  def getPlayerByPosition(position)
    playerAtPosition = @lineup.select {|player| player[:position] == position}
    playerAtPosition[0][:name]
  end

  def currentBatter()
    @lineup[@lineupPosition][:name]
  end

  def advanceLineup()
    if @lineupPosition == 8
      @lineupPosition = 0
    else
      @lineupPosition += 1
    end
  end

end

# new_team = Team.new()
# p new_team.lineup
# p new_team.team_name
# blue_team = Team.new()
# p blue_team.lineup
# p blue_team.team_name


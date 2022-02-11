class Inning
  PITCH_TYPE = ["slider", "changeup", "curveball", "knuckleball", "slider"]

  attr_reader :runs

  def initialize(battingTeam, fieldingTeam)
    @battingTeam = battingTeam
    @fieldingTeam = fieldingTeam
    @outs = 0
    @balls = 0
    @strikes = 0
    @runs = 0
  end

  def complete()
    return true if @outs >= 3
    false
  end

  def pitch()
    p "#{@fieldingTeam.getPlayerByPosition("P")} throws a #{PITCH_TYPE.sample}"
    @strikes += 1
  end

  def resetCount()
    @battingTeam.advanceLineup
    @balls = 0
    @strikes = 0
    p "#{@battingTeam.currentBatter} takes the plate"
  end

  def checkCount()
    if @strikes >= 3
      p "The #{@fieldingTeam.team_name} claim the out"
      @outs += 1
      self.resetCount
    elsif @balls >= 4
      self.advanceRunners(1)
      self.resetCount
      p "#{@fieldingTeam.getPlayerByPosition("P")} is going to give them the walk"
    else
      p "The count is #{@balls} and #{@strikes}"
    end
  end

  def playInning()
    until self.complete
      self.checkCount
      self.pitch
    end
  end

end
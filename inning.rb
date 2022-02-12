class Inning
  PITCH_TYPE = ["slider", "changeup", "curveball", "knuckleball", "slider"]
  STRIKE_LINES = ["A swing and a miss!", "Misjudged the timing on that one.", "Oh, they get caught looking!"]
  BALL_LINES = ["They're going to take the ball", "They aren't falling for it", "They're going to let that one go by", "Aaaand watches it for a ball"]
  HIT_LINES = ["I'm never supposed to say this", "It's a single", "That's going to be a double", "Triple!!", "That one is out of the park! A Home Run!"]

  attr_reader :runs

  def initialize(battingTeam, fieldingTeam)
    @battingTeam = battingTeam
    @fieldingTeam = fieldingTeam
    @outs = 0
    @balls = 0
    @strikes = 0
    @runs = 0
    @runnersOnBase = Array.new(3) {""}
  end

  def complete()
    return true if @outs >= 3
    false
  end

  def advanceRunners(numberOfBases)
    if numberOfBases == 0
      firstEmptyBase = @runnersOnBase.index("")
      @runnersOnBase.delete_at(firstEmptyBase)
    end

    numberOfBases.times do |n|
      if n == 0
        @runnersOnBase.unshift(@battingTeam.currentBatter)
      else
        @runnersOnBase.unshift("")
      end
    end

    until @runnersOnBase.length == 3
      if @runnersOnBase.pop != ""
        @runs += 1
        p "That brings the score to #{@runs}"
      end
    end

    print @runnersOnBase
    
  end

  def pitch()
    p "#{@fieldingTeam.getPlayerByPosition("P")} throws a #{PITCH_TYPE.sample}"
    pitchDiceRoll = rand(1..10)
    if pitchDiceRoll <= 3 
      @strikes += 1
      p "#{STRIKE_LINES.sample}"
    elsif pitchDiceRoll >= 8
      @balls += 1
      "#{BALL_LINES.sample}"
    else
      p "#{HIT_LINES[pitchDiceRoll - 3]}"
      self.advanceRunners(pitchDiceRoll - 3)
      self.resetCount
    end
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
      self.advanceRunners(0)
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
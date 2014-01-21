class Player

  @health = nil

  def play_turn(warrior)

    @health = warrior.health unless @health != nil

    if warrior.feel.empty?

      if warrior.health >= @health && warrior.health < 13
        warrior.rest!
      else
        warrior.walk!
      end

    else

      if warrior.feel.captive?
        warrior.rescue!
      else
        warrior.attack!
      end

    end

    @health = warrior.health

  end
end

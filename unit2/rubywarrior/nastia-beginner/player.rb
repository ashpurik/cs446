class Player

  @health = nil
  MINIMUM = 8
  MAXIMUM = 20
  @saved = nil
  @turned = nil
  @warrior = nil


  def play_turn(warrior)

    @turned = false unless @turned != nil
    @warrior = warrior unless @warrior != nil

    if (enemy_behind? || captive_behind?) && @turned == false
      warrior.pivot! :backward
      @turned = true

    elsif wall_in_front?
      warrior.pivot! :backward

    elsif found_captive?
      warrior.rescue!

    elsif enemy_ahead?
      warrior.shoot!

    else
      warrior.walk!
      
    end
    
  end
  

  def enemy_behind?
    return @warrior.look(:backward).any? { |space| space.enemy? }
  end

  def captive_behind?
    return @warrior.look(:backward).any? { |space| space.captive? }
  end

  def wall_in_front?
    return @warrior.feel.wall?
  end

  def enemy_ahead?
    return @warrior.look.any? { |space| space.enemy? }
  end

  def captive_ahead?
    return @warrior.look.any? { |space| space.captive? }
  end

  def found_captive?
    return @warrior.feel.captive?
  end

  def under_attack?
    return @warrior.health < @health
  end

end


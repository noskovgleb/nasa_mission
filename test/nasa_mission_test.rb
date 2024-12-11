require 'test_helper'

class NasaMissionTest < Minitest::Test
  def test_apollo_11_mission
    mission = NasaMission::Mission.new(28801, [
      [:launch, "earth"],
      [:land, "moon"],
      [:launch, "moon"],
      [:land, "earth"]
    ])
    
    assert_equal 51898, mission.calculate_fuel
  end

  def test_mission_on_mars
    mission = NasaMission::Mission.new(14606, [
      [:launch, "earth"],
      [:land, "mars"],
      [:launch, "mars"],
      [:land, "earth"]
    ])
    
    assert_equal 33388, mission.calculate_fuel
  end

  def test_passenger_ship
    mission = NasaMission::Mission.new(75432, [
      [:launch, "earth"],
      [:land, "moon"],
      [:launch, "moon"],
      [:land, "mars"],
      [:launch, "mars"],
      [:land, "earth"]
    ])
    
    assert_equal 212161, mission.calculate_fuel
  end

  def test_invalid_planet
    assert_raises NasaMission::Error do
      NasaMission::Mission.new(28801, [[:launch, "mercury"]]).calculate_fuel
    end
  end

  def test_invalid_action
    assert_raises NasaMission::Error do
      NasaMission::Mission.new(28801, [[:orbit, "earth"]]).calculate_fuel
    end
  end
end
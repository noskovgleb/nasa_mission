require_relative 'nasa_mission/mission'

module NasaMission
  GRAVITY = {
    'earth' => 9.807,
    'moon' => 1.62,
    'mars' => 3.711
  }.freeze

  class Error < StandardError; end
end
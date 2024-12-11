module NasaMission
  class Mission
    LAUNCH_FUEL_COEFFICIENT = 0.042
    LAUNCH_FUEL_CONSTANT = 33
    LAND_FUEL_COEFFICIENT = 0.033
    LAND_FUEL_CONSTANT = 42

    def initialize(mass, flight_path)
      @mass = mass
      @flight_path = flight_path
    end

    def calculate_fuel
      total_fuel = 0
      current_mass = @mass

      @flight_path.reverse_each do |action, planet|
        gravity = NasaMission::GRAVITY[planet]
        raise Error, "Unknown planet: #{planet}" unless gravity

        fuel = calculate_fuel_for_action(current_mass, gravity, action)
        total_fuel += fuel
        current_mass += fuel
      end

      total_fuel
    end

    private

    def calculate_fuel_for_action(mass, gravity, action)
      case action
      when :launch
        calculate_launch_fuel(mass, gravity)
      when :land
        calculate_land_fuel(mass, gravity)
      else
        raise Error, "Unknown action: #{action}"
      end
    end

    def calculate_launch_fuel(mass, gravity)
      fuel = (mass * gravity * LAUNCH_FUEL_COEFFICIENT - LAUNCH_FUEL_CONSTANT).floor
      additional_fuel = calculate_additional_fuel(fuel) { |f| (f * gravity * LAUNCH_FUEL_COEFFICIENT - LAUNCH_FUEL_CONSTANT).floor }
      fuel + additional_fuel
    end

    def calculate_land_fuel(mass, gravity)
      fuel = (mass * gravity * LAND_FUEL_COEFFICIENT - LAND_FUEL_CONSTANT).floor
      additional_fuel = calculate_additional_fuel(fuel) { |f| (f * gravity * LAND_FUEL_COEFFICIENT - LAND_FUEL_CONSTANT).floor }
      fuel + additional_fuel
    end

    def calculate_additional_fuel(initial_fuel)
      total_additional = 0
      current_fuel = initial_fuel

      while (fuel_for_fuel = yield(current_fuel)) > 0
        total_additional += fuel_for_fuel
        current_fuel = fuel_for_fuel
      end

      total_additional
    end
  end
end
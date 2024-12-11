# NASA Mission Fuel Calculator

A Ruby gem for calculating the required fuel for space missions based on the ship's mass and flight path.

## Requirements

- Ruby 2.0 or higher

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nasa_mission'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install nasa_mission
```

## Usage

### Basic Example

```ruby
require 'nasa_mission'

# Initialize a mission with spacecraft mass and flight path
mission = NasaMission::Mission.new(28801, [
  [:launch, "earth"],
  [:land, "moon"],
  [:launch, "moon"],
  [:land, "earth"]
])

# Calculate required fuel
total_fuel = mission.calculate_fuel  # Returns 51898
```

### Flight Path Format

The flight path is an array of steps, where each step is an array containing:

1. Action (`:launch` or `:land`)
2. Planet name (case-insensitive string: "earth", "moon", or "mars")

Example flight paths:

```ruby
# Apollo 11 mission
flight_path = [
  [:launch, "earth"],
  [:land, "moon"],
  [:launch, "moon"],
  [:land, "earth"]
]

# Mars mission
flight_path = [
  [:launch, "earth"],
  [:land, "mars"],
  [:launch, "mars"],
  [:land, "earth"]
]
```

### Supported Planets

The following planets are supported with their respective gravity values:

- Earth (9.807 m/s²)
- Moon (1.62 m/s²)
- Mars (3.711 m/s²)

## API Documentation

### NasaMission::Mission

#### Initialize

```ruby
initialize(mass, flight_path)
```

- `mass`: Integer - The mass of the spacecraft in kilograms
- `flight_path`: Array - Array of mission steps (see Flight Path Format above)

#### Calculate Fuel

```ruby
calculate_fuel
```

Returns the total fuel required for the mission in kilograms.

### Error Handling

The gem will raise `NasaMission::Error` in the following cases:

- Invalid planet name in flight path
- Invalid action (must be :launch or :land)

## Examples

### Apollo 11 Mission

```ruby
mission = NasaMission::Mission.new(28801, [
  [:launch, "earth"],
  [:land, "moon"],
  [:launch, "moon"],
  [:land, "earth"]
])
fuel = mission.calculate_fuel  # Returns 51898
```

### Mars Mission

```ruby
mission = NasaMission::Mission.new(14606, [
  [:launch, "earth"],
  [:land, "mars"],
  [:launch, "mars"],
  [:land, "earth"]
])
fuel = mission.calculate_fuel  # Returns 33388
```

### Complex Mission (Passenger Ship)

```ruby
mission = NasaMission::Mission.new(75432, [
  [:launch, "earth"],
  [:land, "moon"],
  [:launch, "moon"],
  [:land, "mars"],
  [:launch, "mars"],
  [:land, "earth"]
])
fuel = mission.calculate_fuel  # Returns 212161
```

## Technical Details

### Fuel Calculation Formula

The fuel calculation involves two components:

1. Base fuel calculation
2. Additional fuel for the fuel weight

#### Launch Fuel Formula

```
mass * gravity * 0.042 - 33 (rounded down)
```

#### Landing Fuel Formula

```
mass * gravity * 0.033 - 42 (rounded down)
```

Additional fuel is calculated recursively until no more fuel is needed (when additional fuel calculation results in 0 or negative).

## License

This gem is available under the [MIT License](LICENSE.txt).

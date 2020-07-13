# DenonAvr

This gem allows you to control your Denon AVR home theater receiver programatically.

Current features:

* Power on and off
* Source input select
* Set volume
* Mute and unmute
* Multi-zone support for all functions

## Usage

```ruby
require 'denon_avr'

# For :host, use your receiver's IP address
receiver = DenonAvr::Receiver.new(host: '10.0.1.20')
receiver.power_on
receiver.input = 'Phono'
receiver.volume = 40

# For multi-zone support, instantiate with an optional :add_zones param:
receiver = DenonAvr::Receiver.new(host: '10.0.1.20', add_zones: ['Zone2', 'Zone3'])
receiver.zone2.power_on
receiver.zone2.input = 'CD'
receiver.zone2.volume = 32.0
```

#### Architectural Note

Most functions are implemented on an instance of `Denon::Receiver::Zone` for optimal multi-zone support.  Methods such as `receiver.power_on` are actually delegated to the Main Zone; they are identical to calling, for example, `receiver.main_zone.power_on`.

#### Receiver Status

```ruby
# Example Receiver instantiation
receiver = DenonAvr::Receiver.new(host: '10.0.1.239', add_zones: ['Zone2'])
 # => #<DenonAvr::Receiver:3fd47f0be51c @host="10.0.1.239", @zones=[#<DenonAvr::Receiver::Zone:3fd47f0d64b4 @name="MainZone", @volume=20.0, @input="Sonos", @power="ON", @muted=false>, #<DenonAvr::Receiver::Zone:3fd47f0de5b0 @name="Zone2", @volume=42.0, @input="Sonos", @power="ON", @muted=false>]>

 receiver.host == '10.0.1.239' # No setter on this attribute

 receiver.zones == [receiver.main_zone, receiver.zone2]

 receiver.volume == 20.0
 receiver.volume == receiver.main_zone.volume

 receiver.input == 'Sonos' # Respects renamed input

 receiver.power == 'ON'
 receiver.power == DenonAvr::Receiver::POWER_ON

 # Update status, refreshes all of the above
 receiver.get_status
```

#### Power

```ruby
# Identical
receiver.power = :on
receiver.power = true
receiver.power = 'On'
receiver.power = Denon::Receiver::POWER_ON
receiver.power_on
receiver.main_zone.power_on

# Zones
receiver.zone2.power = true
receiver.zone3.power_on

# Powering off examples
receiver.power = false
receiver.power = :off
receiver.power_off

# Turn off all zones
receiver.all_off
```

#### Mute / Unmute

```ruby
receiver.mute
# These methods are identical
receiver.muted == receiver.muted? == true

receiver.unmute
receiver.muted? == false

receiver.zone2.mute = true
receiver.zone2.muted? == true
```

#### Volume

```ruby
receiver.volume = 24

receiver.zone2.volume = 45.5
```

#### Input Select

```ruby
receiver.input = 'Blu-ray'
receiver.zone2.input = 'CD'

# If you have renamed a source, the new name will be used
receiver.input = 'Apple TV'

# To get a list of source names available, use this method.
# Note that this will return a hash, the value is the internal mapping
# used by the receiver, and the key is the
# "human" name that should be used.
receiver.source_list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Attribution

Although this gem does not seek to keep an identical API or design paradigm, it is essentially a ruby port of scarface-471's excellent [denonavr](https://github.com/scarface-4711/denonavr) python package.  Significant thanks must be given for his excellent and extensive work there, of which this gem only implements a portion.  Kudos!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zeiv/denon_avr.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

require 'denon_avr/receiver/constants'
require 'denon_avr/receiver/zone'

module DenonAvr
  class Receiver
    extend Forwardable

    attr_reader :host, :zones, :source_list, :main_zone, :zone2, :zone3

    def_delegators :@main_zone, :volume, :input, :power, :muted, :set_volume,
      :mute, :unmute, :set_input, :status, :get_status, :power_on, :power_off,
      :mute=, :volume=, :power=, :input=

    def self.send_command(host:, path:, body: nil, method: :get)
      return false unless [:get, :post].include?(method)

      uri = URI("http://#{host}:8080#{path}")

      res = HTTParty.send(method, uri, {
        body: body,
        headers: {
          'Content-Type': 'application/xml'
        }
      })
    end

    def self.app_command(host:, commands: [])
      payload = Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
        xml.tx do
          commands.each_with_index do |command, index|
            xml.cmd(command, id: index+1)
          end
        end
      end

      send_command(host: host, path: APPCOMMAND_URL, body: payload.to_xml, method: :post)
    end

    def initialize(host:, name: nil, show_all_inputs: false, timeout: 2.0, add_zones: NO_ZONES)
      @host = host
      get_source_mapping
      setup_zones(add_zones: add_zones)
    end

    def all_off
      @zones.each do |zone|
        zone.power_off
      end
    end

    def send_command(path:, body: nil, method: :get)
      self.class.send_command(host: @host, path: path, body: body, method: method)
    end

    def app_command(commands = [])
      commands = [commands] if commands.is_a? String
      self.class.app_command(host: @host, commands: commands)
    end

    def inspect
      instance_variables_to_list = [:@host, :@zones]
      instance_vars_string = instance_variables_to_list.map { |v|
        "#{v.to_s}=#{instance_variable_get(v).inspect}"
      }.join(', ')
      "\#<#{self.class}:#{self.object_id.to_s(16).rjust(2, '0')} #{instance_vars_string}>"
    end

    private

    def get_source_mapping
      res = app_command('GetRenameSource')
      raw_source_list = res.parsed_response&.fetch('rx', nil)&.fetch('cmd', nil)
        &.fetch('functionrename', nil)&.fetch('list', nil)
      # This consolidates the results into a hash that can actually be used
      # for source lookups, using the internal source name where applicable.
      @source_list = Hash[raw_source_list.map { |source|
        key = SOURCE_MAPPING[source['name']] || source['name']
        [key, source['rename'].strip]
      }].invert
    end

    def setup_zones(add_zones: NO_ZONES)
      @main_zone = Zone.new(receiver: self)
      @zones = [@main_zone]
      add_zones.each do |zone_name|
        zone_added = Zone.new(receiver: self, name: zone_name)
        @zone2 = zone_added if zone_name == 'Zone2'
        @zone3 = zone_added if zone_name == 'Zone3'
        @zones << zone_added
      end
    end
  end
end

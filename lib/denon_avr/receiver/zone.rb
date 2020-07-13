module DenonAvr
  class Receiver
    class Zone
      attr_reader :name, :status, :volume, :input, :power, :muted

      def initialize(receiver:, name: 'MainZone')
        @receiver = receiver
        @name = name
        get_status
      end

      def power=(power)
        power = :on if power === true
        power = :off if power === false
        power = power.downcase.to_sym
        return false unless [:on, :off].include?(power)
        case power
        when :on
          if power_on.success?
            @power = POWER_ON
          else
            false
          end
        when :off
          if power_off.success?
            @power = POWER_OFF
          else
            false
          end
        end
      end

      def power_on
        send_command(path: urls.command_power_on)
      end

      def power_off
        send_command(path: urls.command_power_standby)
      end

      def mute=(new_mute_state)
        if new_mute_state === true
          if mute.success?
            @muted = true
          else
            nil
          end
        elsif new_mute_state === false
          if unmute.success?
            @muted = false
          else
            nil
          end
        end
      end

      def mute
        send_command(path: urls.command_mute_on)
      end

      def unmute
        send_command(path: urls.command_mute_off)
      end

      def muted?
        muted
      end

      def volume=(new_volume)
        res = set_volume(new_volume)
        if res.success?
          @volume = parse_volume(res.parsed_response)
        else
          false
        end
      end

      def set_volume(volume)
        send_command(path: sprintf(urls.command_set_volume, (volume.to_f - 80.0)))
      end

      def input=(input)
        begin
          if set_input(input).success?
            @muted = true
          else
            false
          end
        rescue UnknownSourceError
          false
        end
      end

      def set_input(input)
        if @receiver.source_list[input].nil?
          raise UnknownSourceError.new("#{input} is not in the receiver's source mapping")
        end
        send_command(path: "#{urls.command_sel_src}#{@receiver.source_list[input]}")
      end

      def get_status
        res = send_command(path: urls.status_lite)
        status_items = res.parsed_response&.fetch('item', {})
        @status = status_items.each{|k,v| status_items[k] = v['value']}
        @input = @receiver.source_list.invert[@status['InputFuncSelect']] || @status['InputFuncSelect']
        @power = @status['Power']
        @muted = @status['Mute'] == 'on' ? true : false
        @volume = parse_volume(res.parsed_response)
      end

      def inspect
        instance_variables_to_list = [:@name, :@volume, :@input, :@power, :@muted]
        instance_vars_string = instance_variables_to_list.map { |v|
          "#{v.to_s}=#{instance_variable_get(v).inspect}"
        }.join(', ')
        "\#<#{self.class}:#{self.object_id.to_s(16).rjust(2, '0')} #{instance_vars_string}>"
      end

      private

      def urls
        case name
        when 'MainZone'
          MAIN_URLS
        when 'Zone2'
          ZONE2_URLS
        when 'Zone3'
          ZONE3_URLS
        end
      end

      def send_command(path:, body: nil, method: :get)
        @receiver.send_command(path: path, body: body, method: method)
      end

      def app_command(host: @host, commands: [])
        @receiver.app_command(commands)
      end

      def parse_volume(xml_response)
        volume_display = xml_response.fetch('item', nil)&.fetch('VolumeDisplay', nil)
        volume_display = volume_display.fetch('value', nil) if volume_display.is_a? Hash
        master_volume = xml_response.fetch('item', nil)&.fetch('MasterVolume', nil)
        master_volume = master_volume.fetch('value', nil) if master_volume.is_a? Hash
        master_volume = master_volume.to_f
        if volume_display == 'Absolute'
          master_volume = 80.0 + master_volume
        end
      end
    end
  end
end

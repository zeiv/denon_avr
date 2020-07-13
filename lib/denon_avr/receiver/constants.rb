module DenonAvr
  class Receiver
    # Image URLs
    STATIC_ALBUM_URL = 'http://{host}:{port}/img/album%20art_S.png'
    ALBUM_COVERS_URL = 'http://{host}:{port}/NetAudio/art.asp-jpg?{time}'

    # General URLs
    APPCOMMAND_URL = '/goform/AppCommand.xml'
    DEVICEINFO_URL = '/goform/Deviceinfo.xml'
    NETAUDIOSTATUS_URL = '/goform/formNetAudio_StatusXml.xml'
    TUNERSTATUS_URL = '/goform/formTuner_TunerXml.xml'
    HDTUNERSTATUS_URL = '/goform/formTuner_HdXml.xml'
    COMMAND_NETAUDIO_POST_URL = '/NetAudio/index.put.asp'
    COMMAND_PAUSE = '/goform/formiPhoneAppDirect.xml?NS9B'
    COMMAND_PLAY = '/goform/formiPhoneAppDirect.xml?NS9A'

    # Main Zone URLs
    STATUS_URL = '/goform/formMainZone_MainZoneXmlStatus.xml'
    STATUS_LITE_URL = '/goform/formMainZone_MainZoneXmlStatusLite.xml'
    MAINZONE_URL = '/goform/formMainZone_MainZoneXml.xml'
    COMMAND_SEL_SRC_URL = '/goform/formiPhoneAppDirect.xml?SI'
    COMMAND_FAV_SRC_URL = '/goform/formiPhoneAppDirect.xml?ZM'
    COMMAND_POWER_ON_URL = '/goform/formiPhoneAppPower.xml?1+PowerOn'
    COMMAND_POWER_STANDBY_URL = '/goform/formiPhoneAppPower.xml?1+PowerStandby'
    COMMAND_VOLUME_UP_URL = '/goform/formiPhoneAppDirect.xml?MVUP'
    COMMAND_VOLUME_DOWN_URL = '/goform/formiPhoneAppDirect.xml?MVDOWN'
    COMMAND_SET_VOLUME_URL = '/goform/formiPhoneAppVolume.xml?1+%.1f'
    COMMAND_MUTE_ON_URL = '/goform/formiPhoneAppMute.xml?1+MuteOn'
    COMMAND_MUTE_OFF_URL = '/goform/formiPhoneAppMute.xml?1+MuteOff'
    COMMAND_SEL_SM_URL = '/goform/formiPhoneAppDirect.xml?MS'
    COMMAND_SET_ZST_URL = '/goform/formiPhoneAppDirect.xml?MN'

    # Zone 2 URLs
    STATUS_Z2_URL = '/goform/formZone2_Zone2XmlStatus.xml'
    STATUS_LITE_Z2_URL = '/goform/formZone2_Zone2XmlStatusLite.xml'
    MAINZONE_Z2_URL = nil
    COMMAND_SEL_SRC_Z2_URL = '/goform/formiPhoneAppDirect.xml?Z2'
    COMMAND_FAV_SRC_Z2_URL = '/goform/formiPhoneAppDirect.xml?Z2'
    COMMAND_POWER_ON_Z2_URL = '/goform/formiPhoneAppPower.xml?2+PowerOn'
    COMMAND_POWER_STANDBY_Z2_URL = '/goform/formiPhoneAppPower.xml?2+PowerStandby'
    COMMAND_VOLUME_UP_Z2_URL = '/goform/formiPhoneAppDirect.xml?Z2UP'
    COMMAND_VOLUME_DOWN_Z2_URL = '/goform/formiPhoneAppDirect.xml?Z2DOWN'
    COMMAND_SET_VOLUME_Z2_URL = '/goform/formiPhoneAppVolume.xml?2+%.1f'
    COMMAND_MUTE_ON_Z2_URL = '/goform/formiPhoneAppMute.xml?2+MuteOn'
    COMMAND_MUTE_OFF_Z2_URL = '/goform/formiPhoneAppMute.xml?2+MuteOff'

    # Zone 3 URLs
    STATUS_Z3_URL = '/goform/formZone3_Zone3XmlStatus.xml'
    STATUS_LITE_Z3_URL = '/goform/formZone3_Zone3XmlStatusLite.xml'
    MAINZONE_Z3_URL = nil
    COMMAND_SEL_SRC_Z3_URL = '/goform/formiPhoneAppDirect.xml?Z3'
    COMMAND_FAV_SRC_Z3_URL = '/goform/formiPhoneAppDirect.xml?Z3'
    COMMAND_POWER_ON_Z3_URL = '/goform/formiPhoneAppPower.xml?3+PowerOn'
    COMMAND_POWER_STANDBY_Z3_URL = '/goform/formiPhoneAppPower.xml?3+PowerStandby'
    COMMAND_VOLUME_UP_Z3_URL = '/goform/formiPhoneAppDirect.xml?Z3UP'
    COMMAND_VOLUME_DOWN_Z3_URL = '/goform/formiPhoneAppDirect.xml?Z3DOWN'
    COMMAND_SET_VOLUME_Z3_URL = '/goform/formiPhoneAppVolume.xml?3+%.1f'
    COMMAND_MUTE_ON_Z3_URL = '/goform/formiPhoneAppMute.xml?3+MuteOn'
    COMMAND_MUTE_OFF_Z3_URL = '/goform/formiPhoneAppMute.xml?3+MuteOff'

    ReceiverURLs = Struct.new(:appcommand, :status, :status_lite, :mainzone, :deviceinfo, :netaudiostatus,
      :tunerstatus, :hdtunerstatus, :command_sel_src, :command_fav_src, :command_power_on,
      :command_power_standby, :command_volume_up, :command_volume_down, :command_set_volume,
      :command_mute_on,  :command_mute_off, :command_sel_sound_mode, :command_netaudio_post,
      :command_set_all_zone_stereo,   :command_pause, :command_play, keyword_init: true)

    MAIN_URLS = ReceiverURLs.new(
      appcommand: APPCOMMAND_URL,
      status: STATUS_URL,
      status_lite: STATUS_LITE_URL,
      mainzone: MAINZONE_URL,
      deviceinfo: DEVICEINFO_URL,
      netaudiostatus: NETAUDIOSTATUS_URL,
      tunerstatus: TUNERSTATUS_URL,
      hdtunerstatus: HDTUNERSTATUS_URL,
      command_sel_src: COMMAND_SEL_SRC_URL,
      command_fav_src: COMMAND_FAV_SRC_URL,
      command_power_on: COMMAND_POWER_ON_URL,
      command_power_standby: COMMAND_POWER_STANDBY_URL,
      command_volume_up: COMMAND_VOLUME_UP_URL,
      command_volume_down: COMMAND_VOLUME_DOWN_URL,
      command_set_volume: COMMAND_SET_VOLUME_URL,
      command_mute_on: COMMAND_MUTE_ON_URL,
      command_mute_off: COMMAND_MUTE_OFF_URL,
      command_sel_sound_mode: COMMAND_SEL_SM_URL,
      command_netaudio_post: COMMAND_NETAUDIO_POST_URL,
      command_set_all_zone_stereo: COMMAND_SET_ZST_URL,
      command_pause: COMMAND_PAUSE,
      command_play: COMMAND_PLAY
    )

    ZONE2_URLS = ReceiverURLs.new(
      appcommand: APPCOMMAND_URL,
      status: STATUS_Z2_URL,
      status_lite: STATUS_LITE_Z2_URL,
      mainzone: MAINZONE_Z2_URL,
      deviceinfo: DEVICEINFO_URL,
      netaudiostatus: NETAUDIOSTATUS_URL,
      tunerstatus: TUNERSTATUS_URL,
      hdtunerstatus: HDTUNERSTATUS_URL,
      command_sel_src: COMMAND_SEL_SRC_Z2_URL,
      command_fav_src: COMMAND_FAV_SRC_Z2_URL,
      command_power_on: COMMAND_POWER_ON_Z2_URL,
      command_power_standby: COMMAND_POWER_STANDBY_Z2_URL,
      command_volume_up: COMMAND_VOLUME_UP_Z2_URL,
      command_volume_down: COMMAND_VOLUME_DOWN_Z2_URL,
      command_set_volume: COMMAND_SET_VOLUME_Z2_URL,
      command_mute_on: COMMAND_MUTE_ON_Z2_URL,
      command_mute_off: COMMAND_MUTE_OFF_Z2_URL,
      command_sel_sound_mode: COMMAND_SEL_SM_URL,
      command_netaudio_post: COMMAND_NETAUDIO_POST_URL,
      command_set_all_zone_stereo: COMMAND_SET_ZST_URL,
      command_pause: COMMAND_PAUSE,
      command_play: COMMAND_PLAY
    )

    ZONE3_URLS = ReceiverURLs.new(
      appcommand: APPCOMMAND_URL,
      status: STATUS_Z3_URL,
      status_lite: STATUS_LITE_Z3_URL,
      mainzone: MAINZONE_Z3_URL,
      deviceinfo: DEVICEINFO_URL,
      netaudiostatus: NETAUDIOSTATUS_URL,
      tunerstatus: TUNERSTATUS_URL,
      hdtunerstatus: HDTUNERSTATUS_URL,
      command_sel_src: COMMAND_SEL_SRC_Z3_URL,
      command_fav_src: COMMAND_FAV_SRC_Z3_URL,
      command_power_on: COMMAND_POWER_ON_Z3_URL,
      command_power_standby: COMMAND_POWER_STANDBY_Z3_URL,
      command_volume_up: COMMAND_VOLUME_UP_Z3_URL,
      command_volume_down: COMMAND_VOLUME_DOWN_Z3_URL,
      command_set_volume: COMMAND_SET_VOLUME_Z3_URL,
      command_mute_on: COMMAND_MUTE_ON_Z3_URL,
      command_mute_off: COMMAND_MUTE_OFF_Z3_URL,
      command_sel_sound_mode: COMMAND_SEL_SM_URL,
      command_netaudio_post: COMMAND_NETAUDIO_POST_URL,
      command_set_all_zone_stereo: COMMAND_SET_ZST_URL,
      command_pause: COMMAND_PAUSE,
      command_play: COMMAND_PLAY
    )

    POWER_ON = 'ON'
    POWER_OFF = 'OFF'
    POWER_STANDBY = 'STANDBY'
    STATE_ON = 'on'
    STATE_OFF = 'off'
    STATE_PLAYING = 'playing'
    STATE_PAUSED = 'paused'

    SOURCE_MAPPING = {"TV AUDIO" => "TV", "iPod/USB" => "USB/IPOD", "Bluetooth" => "BT",
      "Blu-ray" => "BD", "CBL/SAT" => "SAT/CBL", "NETWORK" => "NET",
      "Media Player" => "MPLAY", "AUX" => "AUX1", "Tuner" => "TUNER",
      "FM" => "TUNER", "SpotifyConnect" => "Spotify Connect"}

    NO_ZONES = []
    ZONE2 = ['Zone2'] # {"Zone2": None}
    ZONE3 = ['Zone3'] # {"Zone3": None}
    ZONE2_ZONE3 = ['Zone2', 'Zone3'] # {"Zone2": None, "Zone3": None}
  end
end

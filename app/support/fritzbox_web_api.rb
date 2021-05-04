class FritzboxWebApi

  def initialize(address, password)
    @address = address
    @password = password
  end

  def authenticate
    index_response = HTTParty.get("http://#{@address}/")
    raise "get challenge failed with #{index_response.code}" unless index_response.code == 200

    json_data = index_response.body.match(/^var data = ({.*});$/).captures.first
    data = JSON.parse(json_data)
    challenge = data["challenge"].split '$'

    challenge_version = challenge[0]
    iterations_1 = challenge[1]
    salt_1 = challenge[2]
    iterations_2 = challenge[3]
    salt_2 = challenge[4]

    raise "unsupported challenge version: #{challenge_version}" unless challenge_version.to_s == '2'

    pass_1 = OpenSSL::KDF.pbkdf2_hmac(@password, salt: [salt_1].pack('H*'), iterations: iterations_1.to_i, length: 32, hash: 'sha256')
    pass_2 = OpenSSL::KDF.pbkdf2_hmac(pass_1, salt: [salt_2].pack('H*'), iterations: iterations_2.to_i, length: 32, hash: 'sha256')

    challenge_respsonse = [salt_2, Digest.hexencode(pass_2)].join '$'

    response = HTTParty.post("http://#{@address}/index.lua", body: "response=#{Rack::Utils.escape(challenge_respsonse)}&lp=&username=collectd")
    raise "post challenge failed with #{index_response.code}" unless response.code == 200

    json_data = response.body.match(/^main.init\(({.*})\);$/).captures.first
    data = JSON.parse(json_data)
    data['sid']
  end

  def get_clients
    sid = authenticate

    response = HTTParty.post("http://#{@address}/data.lua", body: "sid=#{sid}&page=wSet")
    raise "get wifi data failed with #{response.code}" unless response.code == 200

    data = JSON.parse(response.body)
    wlan_settings = data['data']['wlanSettings']

    bssid_24 = wlan_settings['mac']
    ssid_24 = wlan_settings['ssid']

    bssid_5 = wlan_settings['macScnd']
    ssid_5 = wlan_settings['ssidScnd']

    wifi_clients = data['data']['wlanSettings']['knownWlanDevices'].map do |client_data|
      next if client_data['type'] == 'passive'

      client = {}

      band_data = if client_data['bands']['ghz24']
        client[:ssid] = ssid_24
        client[:bssid] = bssid_24
        client[:frequency] = 2.4
        client_data['bands']['ghz24']
      elsif client_data['bands']['ghz5']
        client[:ssid] = ssid_5
        client[:bssid] = bssid_5
        client[:frequency] = 5
        client_data['bands']['ghz5']
      else
        raise('no band data found')
      end

      client[:mac] = band_data['mac']
      client[:cipher] = band_data['cipher']
      client[:rssi] = band_data['rssi']
      client[:rate_up] = band_data['rate']['us']
      client[:rate_down] = band_data['rate']['ds']
      client[:props] = band_data['props']
      client
    end
    wifi_clients.compact
  end









end
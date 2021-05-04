class WifiAccessPoint < ApplicationRecord
  belongs_to :ip

  def update_clients!
    WifiClient.transaction do
      clients = get_clients

      macs = clients.map { |c| c[:mac] }
      mac_ids = Mac.where(address: macs).ids

      WifiClient.where.not(mac_id: mac_ids).destroy_all

      clients.each do |client|
        mac = Mac.find_or_initialize_by(address: client[:mac])
        unless mac.persisted?
          mac.host = Host.create!
          mac.save!
        end

        wifi_client = WifiClient.find_or_initialize_by(mac_id: mac.id, wifi_access_point_id: self.id)
        wifi_client.assign_attributes(client.slice(:ssid, :bssid, :frequency, :cipher, :rssi, :rate_up, :rate_down, :props))
        wifi_client.last_seen = Time.now
        wifi_client.save!
      end
    end
  end

  protected

  def get_clients
    raise NotImplementedError
  end

end

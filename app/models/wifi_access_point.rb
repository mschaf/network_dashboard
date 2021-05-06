class WifiAccessPoint < ApplicationRecord

  belongs_to :ip
  has_many :wifi_clients

  assignable_values_for :type, default: 'WifiAccessPoint::Fritzbox' do
    %w[WifiAccessPoint::Fritzbox]
  end

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

  def display_name
    name.presence || ip.mac.host.name.presence || '-'
  end

  def to_s
    display_name
  end

  def password=(password)
    if password.present?
      super(password)
    end
  end

  protected

  def get_clients
    raise NotImplementedError
  end

end

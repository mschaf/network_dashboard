class CreateWifiClients < ActiveRecord::Migration[6.1]
  def change
    create_table :wifi_clients do |t|
      t.references :mac
      t.references :wifi_access_point
      t.timestamp :last_seen

      t.string :ssid
      t.string :bssid
      t.string :cipher
      t.decimal :frequency
      t.integer :rssi
      t.integer :rate_up
      t.integer :rate_down
      t.string :props

      t.timestamps
    end
  end
end

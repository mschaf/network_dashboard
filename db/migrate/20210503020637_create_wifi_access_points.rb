class CreateWifiAccessPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :wifi_access_points do |t|
      t.string :type
      t.references :ip
      t.string :password
      t.timestamp :last_seen

      t.timestamps
    end
  end
end

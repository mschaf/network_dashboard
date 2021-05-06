class AddNameToWifiAccessPoints < ActiveRecord::Migration[6.1]
  def change
    add_column :wifi_access_points, :name, :string
  end
end

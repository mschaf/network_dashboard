class CreateIps < ActiveRecord::Migration[6.1]
  def change
    create_table :ips do |t|
      t.string :type
      t.string :address
      t.references :mac
      t.datetime :last_seen_by_ping
      t.boolean :static_dhcp

      t.index :address, unique: true

      t.timestamps
    end
  end
end

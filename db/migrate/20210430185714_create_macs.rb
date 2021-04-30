class CreateMacs < ActiveRecord::Migration[6.1]
  def change
    create_table :macs do |t|
      t.string :address
      t.datetime :last_seen_by_arp
      t.boolean :static
      t.references :host

      t.timestamps
    end
  end
end

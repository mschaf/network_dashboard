class CreateHostScan < ActiveRecord::Migration[6.1]
  def change
    create_table :host_scans do |t|
      t.string :target
      t.boolean :up
      t.datetime :scanned_at
      t.string :state
      t.jsonb :result, default: {}
      t.string :type

      t.references :range_scan, optional: true
      t.references :address

      t.timestamps
    end
  end
end

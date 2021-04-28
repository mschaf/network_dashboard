class CreateRangeScan < ActiveRecord::Migration[6.1]
  def change
    create_table :range_scans do |t|
      t.string :target_range
      t.string :scan_type

      t.timestamps
    end
  end
end

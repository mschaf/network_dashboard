class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.string :mac, index: { unique: true }
      t.string :human_name
      t.string :hostname
      t.datetime :last_up
      t.string :flags, array: true, default: []

      t.timestamps
    end
  end
end

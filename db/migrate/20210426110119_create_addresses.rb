class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :type
      t.boolean :reachable
      t.references :host

      t.timestamps
    end
  end
end

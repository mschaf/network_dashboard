class CreateHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :hostnames do |t|
      t.string :name
      t.boolean :static_dns
      t.references :ip

      t.timestamps
    end
  end
end

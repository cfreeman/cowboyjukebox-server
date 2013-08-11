class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :imei
      t.float :lat
      t.float :lon
      t.float :slat
      t.float :slon

      t.timestamps
    end

    drop_table :positions
    add_index :instruments, [:imei]
  end
end

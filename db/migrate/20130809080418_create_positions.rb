class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :imei
      t.float :lat
      t.float :lon

      t.timestamps
    end

   	add_index :positions, [:imei, :created_at]
  end
end

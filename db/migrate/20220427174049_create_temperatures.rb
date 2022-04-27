class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.decimal :temp, precision: 2, scale: 2

      t.timestamps
    end
  end
end

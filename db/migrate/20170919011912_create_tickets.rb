class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :plate
      t.datetime :init
      t.datetime :exit
      t.string :vtype
      t.integer :price

      t.timestamps
    end
  end
end

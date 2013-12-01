class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :fname
      t.string :mname
      t.string :lname
      t.text :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :withhold
      t.boolean :married
      t.decimal :hourrate

      t.timestamps
    end
  end
end

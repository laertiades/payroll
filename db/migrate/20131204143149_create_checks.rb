class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.decimal :hours
      t.decimal :rate
      t.decimal :gross
      t.decimal :fedtax
      t.decimal :soctax
      t.decimal :medtax
      t.decimal :emsoctax
      t.decimal :emmedtax
      t.decimal :net

      t.timestamps
    end
  end
end

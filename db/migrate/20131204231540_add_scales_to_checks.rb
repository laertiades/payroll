class AddScalesToChecks < ActiveRecord::Migration
  def change
    change_column :checks, :gross, :decimal, precision: 8, scale:2
    change_column :checks, :fedtax, :decimal, precision: 8, scale:2
    change_column :checks, :soctax, :decimal, precision: 8, scale:2
    change_column :checks, :medtax, :decimal, precision: 8, scale:2
    change_column :checks, :emsoctax, :decimal, precision: 8, scale:2
    change_column :checks, :emmedtax, :decimal, precision: 8, scale:2
    change_column :checks, :net, :decimal, precision: 8, scale:2
  end
end

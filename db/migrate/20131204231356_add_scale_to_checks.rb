class AddScaleToChecks < ActiveRecord::Migration
  def change
    change_column :checks, :rate, :decimal, precision: 8, scale:2
  end
end

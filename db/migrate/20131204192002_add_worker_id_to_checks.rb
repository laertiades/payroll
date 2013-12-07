class AddWorkerIdToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :worker_id, :integer
  end
end

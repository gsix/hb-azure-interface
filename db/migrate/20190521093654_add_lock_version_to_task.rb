class AddLockVersionToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :hubstaff_lock_version, :integer
  end
end

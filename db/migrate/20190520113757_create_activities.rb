class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :tracked
      t.string :hubstaff_id
      t.references :project
      t.references :task

      t.timestamps
    end
  end
end

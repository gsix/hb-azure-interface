class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :azure_id
      t.string :hubstaff_id
      t.references :member, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

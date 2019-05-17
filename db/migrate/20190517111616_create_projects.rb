class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :organization, foreign_key: true
      t.string :azure_id
      t.string :azure_name
      t.string :hubstaff_id

      t.timestamps
    end
  end
end

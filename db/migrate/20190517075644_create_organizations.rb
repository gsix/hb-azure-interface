class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :azure_id
      t.string :hubstaff_id

      t.timestamps
    end
  end
end

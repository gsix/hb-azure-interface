class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :azure_id
      t.string :hubstaff_id

      t.timestamps
    end
  end
end

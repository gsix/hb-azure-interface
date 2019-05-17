class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :organizations, :members do |t|
      t.index [:organization_id, :member_id]
      t.index [:member_id, :organization_id]
    end
  end
end

class AddHubstaffTokenWillEndToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :hubstaff_token_will_end, :datetime
  end
end

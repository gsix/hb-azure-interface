class AddHubstaffStartAuthCodeToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :hubstaff_start_auth_code, :string
    add_column :organizations, :hubstaff_access_token, :string
    add_column :organizations, :hubstaff_token_get_at, :datetime
    add_column :organizations, :hubstaff_refresh_token, :string
  end
end

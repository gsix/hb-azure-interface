class AddAzureAccessTokenToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :azure_access_token, :string
  end
end

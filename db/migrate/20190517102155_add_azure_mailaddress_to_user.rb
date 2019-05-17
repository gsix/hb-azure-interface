class AddAzureMailaddressToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :azure_email, :string
  end
end

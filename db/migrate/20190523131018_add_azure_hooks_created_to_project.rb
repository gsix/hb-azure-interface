class AddAzureHooksCreatedToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :azure_hooks_created, :boolean, defualt: false
    add_column :projects, :created_in_hubstaff, :boolean, defualt: false
  end
end

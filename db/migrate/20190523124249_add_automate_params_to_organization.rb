class AddAutomateParamsToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :auto_create_azure_hooks_on_project_create, :boolean, default: true
    add_column :organizations, :auto_create_hubstaff_project_on_project_create, :boolean, default: true
  end
end

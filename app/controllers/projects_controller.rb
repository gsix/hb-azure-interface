class ProjectsController < ApplicationController
  before_action :find_project, only: %i(create_in_hb show edit update)

  def azure_list
    @organization = Organization.find(params[:organization_id])

    res = AzureClient.new.projects @organization.azure_id, @organization.azure_access_token

    res.parsed_response['value'].each do |raw_project|
      next if Project.where(azure_id: raw_project['id']).any?

      project = Project.new
      project.azure_id = raw_project['id']
      project.azure_name = raw_project['name']
      project.organization = @organization

      project.save
      project.azure_hooks_create
    end
  rescue => e
    Rails.logger.error e
  ensure
    redirect_to organization_path @organization
  end

  def create_in_hb
    @project.create_project_in_hubstaff

    Rails.cache.clear
  rescue => e
    Rails.logger.error e
  ensure
    redirect_to edit_project_path(@project)
  end

  def edit
    @hubstaff_projects = @project.organization.hubstaff_projects
  end

  def update
    if @project.update_attributes project_params
      redirect_to project_path @project
    else
      render :edit
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:hubstaff_id)
  end
end

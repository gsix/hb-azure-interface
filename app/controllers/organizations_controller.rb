class OrganizationsController < ApplicationController
  before_action :find_organization, only: %i(show edit update destroy)

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new organization_params
    if @organization.save
      redirect_to organization_path @organization
    else
      render :new
    end
  end

  def update
    if @organization.update_attributes organization_params
      redirect_to organization_path @organization
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path
  end

  private

  def find_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:azure_id, :azure_access_token, :hubstaff_id)
  end
end

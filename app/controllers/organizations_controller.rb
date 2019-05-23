class OrganizationsController < ApplicationController
  before_action :find_organization, only: %i(show edit update destroy edit_hubstaff_access update_hubstaff_start_auth_code)
  skip_before_action :authenticate_user!, only: %i(hubstaff_start_auth_code)

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

  def update_hubstaff_start_auth_code
    if @organization.update_attributes organization_exparams

      res = HubstaffClient.new.access_token_request @organization.hubstaff_start_auth_code

      raise StandardError, res.parsed_response['error'] if res.code != 200

      @organization.hubstaff_access_token = res.parsed_response['access_token']
      @organization.hubstaff_refresh_token = res.parsed_response['refresh_token']
      @organization.hubstaff_token_get_at = DateTime.now
      @organization.hubstaff_token_will_end = DateTime.now + (res.parsed_response['expires_in'].to_i / 60.0 / 60.0).round.hours
      @organization.save!

      redirect_to organization_path @organization
    else
      render :edit_hubstaff_access
    end
  rescue => e
    Rails.logger.error e

    render :edit_hubstaff_access
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
    params.require(:organization).permit(:azure_id, :azure_access_token, :hubstaff_id, :auto_create_hubstaff_project_on_project_create, :auto_create_azure_hooks_on_project_create)
  end

  def organization_exparams
    params.require(:organization).permit(:hubstaff_start_auth_code)
  end
end

class MembersController < ApplicationController
  before_action :find_member, only: %i(show edit update)

  def azure_list
    @organization = Organization.find(params[:organization_id])

    res = AzureClient.new.members @organization.azure_id, @organization.azure_access_token

    res.parsed_response['members'].each do |raw_member|
      member = Member.find_or_initialize_by azure_id: raw_member['id']

      member.azure_email = raw_member['user']['mailAddress']

      if member.organizations.select {|org| org.id == @organization.id }.blank?
        member.organizations << @organization
      end

      member.save
    end
  rescue => e
    Rails.logger.error e
  ensure
    redirect_to organization_path @organization
  end

  def update
    if @member.update_attributes member_params
      redirect_to member_path @member
    else
      render :edit
    end
  end

  private

  def find_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:hubstaff_id)
  end
end

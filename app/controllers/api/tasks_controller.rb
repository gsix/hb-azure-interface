class Api::TasksController < Api::BaseController

  def azure_hook_create
    render json: {}, status: :ok and return if params[:resource][:fields]['System.AssignedTo'].nil?

    task = Task.new

    task.title = params[:resource][:fields]['System.Title']
    task.azure_id = params[:resource][:id]

    project = Project.find_by_azure_id!(params[:resourceContainers][:project][:id])
    task.project = project

    member_email = params[:resource][:fields]['System.AssignedTo'].match(/.*<(?<email>.*)>/)[:email]
    member = Member.find_by_azure_email!(member_email)
    task.member = member

    res = HubstaffClient.new.task_create task.project.organization.fresh_hubstaff_access_token, task.project.hubstaff_id, task.title, task.member.hubstaff_id
    task.hubstaff_id = res.parsed_response['task']['id']

    task.save!

    render json: {}, status: :ok
  end

  def azure_hook_update
    byebug
  end

  def azure_hook_destroy
    byebug
  end
end

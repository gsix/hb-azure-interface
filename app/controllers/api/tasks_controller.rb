class Api::TasksController < Api::BaseController

  def azure_hook_create
    render json: {}, status: :ok and return if params[:resource][:fields]['System.AssignedTo'].nil?

    task = Task.new

    task.azure_id = params[:resource][:id]
    task.title = params[:resource][:fields]['System.Title']

    project = Project.find_by_azure_id!(params[:resourceContainers][:project][:id])
    task.project = project

    member_email = params[:resource][:fields]['System.AssignedTo'].match(/.*<(?<email>.*)>/)[:email]
    member = Member.find_by_azure_email!(member_email)
    task.member = member

    res = HubstaffClient.new.task_create task.project.organization.fresh_hubstaff_access_token, task.project.hubstaff_id, task.title, task.member.hubstaff_id
    task.hubstaff_id = res.parsed_response['task']['id']
    task.hubstaff_lock_version = res.parsed_response['task']['lock_version']

    task.save!

    render json: {}, status: :ok
  end

  def azure_hook_update
    render json: {}, status: :ok and return if params[:resource][:revision][:fields]['System.AssignedTo'].nil?

    task = Task.find_or_initialize_by azure_id: params[:resource][:revision][:id]
    task.title = params[:resource][:revision][:fields]['System.Title']

    project = Project.find_by_azure_id!(params[:resourceContainers][:project][:id])
    task.project = project

    member_email = params[:resource][:revision][:fields]['System.AssignedTo'].match(/.*<(?<email>.*)>/)[:email]
    member = Member.find_by_azure_email!(member_email)
    task.member = member

    # update or create in hb
    if task.hubstaff_id
      res = HubstaffClient.new.task_update task.project.organization.fresh_hubstaff_access_token, task.hubstaff_id, task.title, task.member.hubstaff_id, task.hubstaff_lock_version
    else
      res = HubstaffClient.new.task_create task.project.organization.fresh_hubstaff_access_token, task.project.hubstaff_id, task.title, task.member.hubstaff_id
      task.hubstaff_id = res.parsed_response['task']['id']
    end
    task.hubstaff_lock_version = res.parsed_response['task']['lock_version']

    task.save!

    render json: {}, status: :ok
  end

  def azure_hook_destroy
    task = Task.find_by azure_id: params[:resource][:id]

    render json: {}, status: :ok and return unless task.present?

    HubstaffClient.new.task_delete task.project.organization.fresh_hubstaff_access_token, task.hubstaff_id

    task.destroy

    render json: {}, status: :ok
  end
end

class AzureClient
  def initialize
  end

  # in hours - float
  def task_update_completed_work organization_id, project_id, task_id, hours, access_token
    HTTParty.patch("https://dev.azure.com/#{organization_id}/#{project_id}/_apis/wit/workitems/#{task_id}?api-version=5.0", {
      body: [
        {
          op: 'add',
          path: '/fields/Microsoft.VSTS.Scheduling.CompletedWork',
          value: hours
        }
      ].to_json,
      headers: {
        'Content-Type' => 'application/json-patch+json',
        Accept: 'application/json'
      },
      basic_auth: { username: '', password: access_token }
    })
  end

  def members organization_id, access_token
    HTTParty.get("https://vsaex.dev.azure.com/#{organization_id}/_apis/userentitlements?top=10000&api-version=5.0-preview.2", {
      basic_auth: { username: '', password: access_token }
    })
  end

  def projects organization_id, access_token
    HTTParty.get("https://dev.azure.com/#{organization_id}/_apis/projects?$top=10000&api-version=5.0", {
      basic_auth: { username: '', password: access_token }
    })
  end
end

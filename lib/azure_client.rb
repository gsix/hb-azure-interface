class AzureClient
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

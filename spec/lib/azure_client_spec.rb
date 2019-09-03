# frozen_string_literal: true

describe AzureClient, type: :lib do
  let(:instance) { described_class.new }

  describe '#task_update_completed_work', :web_mocked do
    let(:organization_id) { rand.to_s }
    let(:project_id)      { rand.to_s }
    let(:task_id)         { rand.to_s }
    let(:hours)           { rand.round 2 }
    let(:access_token)    { rand.to_s }
    let(:response_body)   { { sample: rand.to_s } }

    before do
      stub_request(:patch, "https://dev.azure.com/#{organization_id}/#{project_id}/_apis/wit/workitems/#{task_id}?api-version=5.0").
          with(body:
                   [{
                        op: 'add',
                        path: '/fields/Microsoft.VSTS.Scheduling.CompletedWork',
                        value: hours
                    }].to_json).
          to_return(status: 200,
                    body: response_body.to_json,
                    headers: default_headers)
    end

    subject { instance.task_update_completed_work organization_id, project_id, task_id, hours, access_token }

    it 'Main case' do
      is_expected.to be_a HTTParty::Response
      is_expected.to have_attributes parsed_response: response_body.stringify_keys
    end
  end

  describe '#project_subscription_create' do
    it 'Main case'
  end

  describe '#members' do
    it 'Main case'
  end

  describe '#projects' do
    it 'Main case'
  end
end

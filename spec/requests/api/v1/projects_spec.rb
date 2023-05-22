require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe "GET /index" do
    let(:project_num) { 10 }
    let(:http_request) { get api_v1_projects_path, headers: headers }

    before do
      create_list(:project, project_num, user: user)
    end

    it 'returns projects in json format' do
      http_request

      expect(body["data"].count).to eq(project_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  # describe 'GET /projects/{id}' do
  #   let(:project) { create(:project, user: user) }
  #   let(:http_request) { get api_v1_projects_path(project), headers: headers }

  #   it 'returns project in json format' do
  #     http_request

  #     expect(body[0]['id']).to eq(project.id)
  #     expect(response).to be_successful
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end

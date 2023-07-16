require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:other_project) { create(:project, user: other_user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
  end

  describe "GET /index" do
    let(:project_num) { 10 }
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
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

  describe 'GET /projects/{id}' do
    let(:project) { create(:project, user: user) }
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
    let(:http_request) { get api_v1_projects_path(project), headers: headers }

    it 'returns project in json format' do
      http_request

      expect(body['data'][0]['id']).to eq(project.id)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/projects' do
    before do
      authorization_stub
    end

    let(:form_project) do
      {
        project_form: {
          title: 'Test Project',
          body: 'This is a test project.',
          piety_category_id: "1",
          piety_target_id: "1",
          cost: "10",
          limit_day: "5",
          tasks: "[]",
          actions: "[]"
        }
      }
    end

    let(:headers) do
      {
        'Content-Type' => 'multipart/form-data'
      }
    end

    it 'creates a new project' do
      post '/api/v1/projects', params: form_project, headers: headers

      # puts response.body
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'when accessed by the owner user' do
      before do
        authorization_stub
        get "/api/v1/projects/#{project.id}/edit"
      end

      it 'returns the project for editing' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when accessed by a different user' do
      before do
        authorization_stub
        get "/api/v1/projects/#{other_project.id}/edit"
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_title) { 'Updated Project' }
    let(:updated_body) { 'This is an updated project' }
    let(:updated_params) do
      {
        project_form: {
          title: updated_title,
          body: updated_body,
          piety_category_id: "1",
          piety_target_id: "1",
          cost: "10",
          limit_day: "5",
          tasks: "[]",
          actions: "[]"
        }
      }
    end

    context 'when updated by the owner user' do
      before do
        authorization_stub
        patch "/api/v1/projects/#{project.id}", params: updated_params
        project.reload
      end

      it 'updates the project' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end

      it 'updates the project attributes' do
        expect(project.title).to eq(updated_title)
        expect(project.body).to eq(updated_body)
      end
    end

    context 'when updated by a different user' do
      before do
        authorization_stub
        patch "/api/v1/projects/#{other_project.id}", params: updated_params
        project.reload
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end

      it "doesn't update the project attributes" do
        expect(project.title).to_not eq(updated_title)
        expect(project.body).to_not eq(updated_body)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when deleted by the owner user' do
      before do
        authorization_stub
        delete "/api/v1/projects/#{project.id}"
      end

      it 'deletes the project' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when deleted by a different user' do
      before do
        authorization_stub
        delete "/api/v1/projects/#{other_project.id}"
      end

      it "returns a forbidden error" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

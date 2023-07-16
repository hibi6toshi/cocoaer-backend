require 'rails_helper'

RSpec.describe "Api::V1::Forums", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let(:forum) { create(:forum, user: user) }
  let(:other_forum) { create(:forum, user: other_user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
  end

  describe "GET /index" do
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
    let(:forum_num) { 10 }
    let(:http_request) { get api_v1_forums_path, headers: headers }

    before do
      create_list(:forum, forum_num, user: user)
    end

    it 'returns forums in json format' do
      http_request

      expect(body["data"].count).to eq(forum_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /forums/{id}' do
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
    let(:forum) { create(:forum, user: user) }
    let(:http_request) { get api_v1_forums_path(forum), headers: headers }

    it 'returns forum in json format' do
      http_request

      expect(body['data'][0]['id']).to eq(forum.id)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/forums' do
    before do
      authorization_stub
    end

    let(:form_forum) do
      {
        forum: {
          title: 'Test Forum',
          body: 'This is a test forum.',
          piety_category_id: "1",
          piety_target_id: "1",
          cost: "10",
          days: "5"
        }
      }
    end

    let(:headers) do
      {
        'Content-Type' => 'multipart/form-data'
      }
    end

    it 'creates a new forum' do
      post '/api/v1/forums', params: form_forum, headers: headers

      # puts response.body
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'when accessed by the owner user' do
      before do
        authorization_stub
        get "/api/v1/forums/#{forum.id}/edit"
      end

      it 'returns the forum for editing' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when accessed by a different user' do
      before do
        authorization_stub
        get "/api/v1/forums/#{other_forum.id}/edit"
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_title) { 'Updated Forum' }
    let(:updated_body) { 'This is an updated forum' }
    let(:updated_params) do
      {
        forum: {
          title: updated_title,
          body: updated_body,
        }
      }
    end

    context 'when updated by the owner user' do
      before do
        authorization_stub
        patch "/api/v1/forums/#{forum.id}", params: updated_params
        forum.reload
      end

      it 'updates the forum' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end

      it 'updates the forum attributes' do
        expect(forum.title).to eq(updated_title)
        expect(forum.body).to eq(updated_body)
      end
    end

    context 'when updated by a different user' do
      before do
        authorization_stub
        patch "/api/v1/forums/#{other_forum.id}", params: updated_params
        forum.reload
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end

      it "doesn't update the forum attributes" do
        expect(forum.title).to_not eq(updated_title)
        expect(forum.body).to_not eq(updated_body)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when deleted by the owner user' do
      before do
        authorization_stub
        delete "/api/v1/forums/#{forum.id}"
      end

      it 'deletes the forum' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when deleted by a different user' do
      before do
        authorization_stub
        delete "/api/v1/forums/#{other_forum.id}"
      end

      it "returns a forbidden error" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

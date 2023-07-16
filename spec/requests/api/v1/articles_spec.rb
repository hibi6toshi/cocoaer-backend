require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) {create(:user) }
  let(:article) { create(:article, user: user) }
  let(:other_article) { create(:article, user: other_user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
  end

  describe "GET /index" do
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
    let(:article_num) { 10 }
    let(:http_request) { get api_v1_articles_path, headers: headers }

    before do
      create_list(:article, article_num, user: user)
    end

    it 'returns articles in json format' do
      http_request

      expect(body['data'].count).to eq(article_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/{id}' do
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
    let(:article) { create(:article, user: user) }
    let(:http_request) { get api_v1_articles_path(article), headers: headers }

    it 'returns article in json format' do
      http_request

      expect(body['data'][0]['id']).to eq(article.id)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/articles' do
    before do
      authorization_stub
    end

    let(:form_article) do
      {
        article: {
          title: 'Test Article',
          body: 'This is a test article.',
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

    it 'creates a new article' do
      post '/api/v1/articles', params: form_article, headers: headers

      # puts response.body
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'when accessed by the owner user' do
      before do
        authorization_stub
        get "/api/v1/articles/#{article.id}/edit"
      end

      it 'returns the article for editing' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when accessed by a different user' do
      before do
        authorization_stub
        get "/api/v1/articles/#{other_article.id}/edit"
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_title) { 'Updated Article' }
    let(:updated_body) { 'This is an updated article' }
    let(:updated_params) do
      {
        article: {
          title: updated_title,
          body: updated_body,
        }
      }
    end

    context 'when updated by the owner user' do
      before do
        authorization_stub
        patch "/api/v1/articles/#{article.id}", params: updated_params
        article.reload
      end

      it 'updates the article' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end

      it 'updates the article attributes' do
        expect(article.title).to eq(updated_title)
        expect(article.body).to eq(updated_body)
      end
    end

    context 'when updated by a different user' do
      before do
        authorization_stub
        patch "/api/v1/articles/#{other_article.id}", params: updated_params
        article.reload
      end

      it 'returns a not_found error' do
        expect(response).to have_http_status(:not_found)
      end

      it "doesn't update the article attributes" do
        expect(article.title).to_not eq(updated_title)
        expect(article.body).to_not eq(updated_body)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when deleted by the owner user' do
      before do
        authorization_stub
        delete "/api/v1/articles/#{article.id}"
      end

      it 'deletes the article' do
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    context 'when deleted by a different user' do
      before do
        authorization_stub
        delete "/api/v1/articles/#{other_article.id}"
      end

      it "returns a forbidden error" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe "GET /index" do
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
    let(:article) { create(:article, user: user) }
    let(:http_request) { get api_v1_articles_path(article), headers: headers }

    it 'returns article in json format' do
      http_request

      expect(body['data'][0]['id']).to eq(article.id)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end

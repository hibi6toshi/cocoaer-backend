require 'rails_helper'

RSpec.describe "Api::V1::MyPosts", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
    authorization_stub
  end

  describe "GET /index" do
    it "returns a list of myposts for a given user and content_type" do
      create_list(:article, 10, user: user)
      get "/api/v1/my_post", params: { content_type: "Article" }

      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 10
    end

    it "not returns a list of myposts for a given another user and content_type" do
      create_list(:article, 10, user: other_user)
      get "/api/v1/my_post", params: { content_type: "Article" }

      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 0
    end
  end
end

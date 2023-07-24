require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:other_article) { create(:article, user: other_user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
    authorization_stub
  end

  describe "GET #index" do

    before do
      create_list(:favorite, 10, :with_article, user: user)
    end

    it "returns a list of favorites for a given user and favoritable_type" do
      get "/api/v1/favorites", params: { favoritable_type: "Article" }

      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 10
    end

    it "not returns a list of favorites for a given user and favoritable_type" do
      get "/api/v1/favorites", params: { favoritable_type: "Project" }

      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 0
    end
  end

  describe "POST #create" do
    it "creates a favorite for the given user and favoritable" do
      post "/api/v1/favorites", params: { favoritable_type: "Article", favoritable_id: other_article.id }

      expect(response).to have_http_status(:success)
      expect(user.favorited_articles).to include(other_article)
    end
  end
  
  describe "DELETE #destroy" do

    before do
      create(:favorite, user: user, favoritable: other_article) # ユーザーが記事をお気に入りに追加する
    end

    it "destroys a favorite for the given user and favoritable" do
      delete "/api/v1/favorites/fake", params: { favoritable_type: "Article", favoritable_id: other_article.id }

      expect(response).to have_http_status(:success)
      expect(user.favorited_articles).not_to include(other_article) # ユーザーが記事をお気に入りから削除したことを確認
    end
  end
end

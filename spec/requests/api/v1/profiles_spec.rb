require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  let!(:user) { create(:user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    authorization_stub
  end

  describe "GET #show" do
    it "returns the user's profile" do
      get "/api/v1/profile"

      expect(response).to have_http_status(:success)
      expect(body["data"]["id"]).to eq(user.id)
      expect(body["data"]["name"]).to eq(user.name)
      expect(body["data"]["introduction"]).to eq(user.introduction)
    end
  end

  describe "PATCH #update" do
    let(:new_name) { "New Name" }
    let(:new_introduction) { "New Introduction" }

    it "updates the user's profile" do
      patch "/api/v1/profile", params: { profile: { name: new_name, introduction: new_introduction } }

      expect(response).to have_http_status(:success)
      expect(body["data"]["name"]).to eq(new_name)
      expect(body["data"]["introduction"]).to eq(new_introduction)

      # ユーザーオブジェクトが実際に更新されていることを確認する
      user.reload
      expect(user.name).to eq(new_name)
      expect(user.introduction).to eq(new_introduction)
    end
  end
end

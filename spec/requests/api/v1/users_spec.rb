require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
  end

  describe "GET /show" do
    before do
      authorization_stub
    end

    it "return user" do
      get "/api/v1/users/#{other_user.id}"

      expect(response).to have_http_status(:success)
      expect(body['data']['id']).to eq other_user.id
    end
  end

  describe "DELTE/ destroy" do
    before do
      authorization_stub
    end

    it "return user" do
      delete "/api/v1/users/#{user.id}"

      expect(response).to have_http_status(:success)
      expect { user.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

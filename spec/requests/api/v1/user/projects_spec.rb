require 'rails_helper'

RSpec.describe "Api::V1::User::Projects", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) {create(:user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  describe "GET /show" do
    before do
      FactoryBot.create(:piety_category)
      FactoryBot.create(:piety_target)
      create_list(:project, 10, user: other_user)
      authorization_stub
    end

    it 'creates a new project' do
      get "/api/v1/users/#{other_user.id}/projects"

      expect(response).to have_http_status(:ok)
      expect(body['data'].count).to eq 10
    end
  end
end

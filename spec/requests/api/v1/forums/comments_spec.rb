require 'rails_helper'

RSpec.describe "Api::V1::Forums::Comments", type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:forum) { create(:forum, user: user) }
  let(:comment_forum) { create(:comment, :with_forum, user: user) }
  let(:other_comment_forum) { create(:comment, :with_forum, user: other_user) }
  let!(:authorization_service) { instance_double(AuthorizationService) }

  before do
    FactoryBot.create(:piety_category)
    FactoryBot.create(:piety_target)
  end

  describe "GET /index" do
    it "returns a list of comments for a given forum id" do
      get "/api/v1/forums/#{comment_forum.commentable.id}/comments"
      expect(response).to have_http_status(:success)
      expect(body['data'].count).to eq 1
      expect(body['data'][0]["commentable_id"]).to eq comment_forum.commentable.id
    end
  end

  describe "POST /create" do
    context "when user is authenticated" do
      let(:valid_params) { { comment: { body: "This is a comment." } } }

      before do
        authorization_stub
        post "/api/v1/forums/#{forum.id}/comments", params: valid_params
      end

      it "creates a new comment for the forum" do
        expect(response).to have_http_status(:success)
        expect(body['data']).to include('id', 'commentable_id', 'body', 'user')
        expect(body['data']['body']).to eq "This is a comment."
      end
    end

    context "when user is not authenticated" do
      let(:valid_params) { { comment: { body: "This is a comment." } } }

      it "returns unauthorized status" do
        post "/api/v1/forums/#{forum.id}/comments", params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update" do
    context "when user is authenticated" do
      let(:valid_params) { { comment: { body: "Updated comment." } } }

      before do
        authorization_stub
        patch "/api/v1/forums/#{comment_forum.commentable.id}/comments/#{comment_forum.id}", params: valid_params
      end

      it "updates the comment with new body" do
        expect(response).to have_http_status(:success)
        expect(body['data']).to include('id', 'commentable_id', 'body', 'user')
        expect(body['data']['body']).to eq "Updated comment."
      end
    end

    context "when user is not the owner of the comment" do
      let(:valid_params) { { comment: { body: "Updated comment." } } }

      before do
        authorization_stub
        patch "/api/v1/forums/#{other_comment_forum.commentable.id}/comments/#{other_comment_forum.id}", params: valid_params
      end

      it "returns unauthorized status" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /destroy" do
    context "when user is authenticated" do
      before do
        authorization_stub
        delete "/api/v1/forums/#{comment_forum.commentable.id}/comments/#{comment_forum.id}"
      end

      it "deletes the comment" do
        expect(response).to have_http_status(:success)
        expect(body['data']).to include('id')
        expect(body['data']['id']).to eq comment_forum.id
      end
    end

    context "when user is not the owner of the comment" do
      before do
        authorization_stub
        delete "/api/v1/forums/#{other_comment_forum.commentable.id}/comments/#{other_comment_forum.id}"
      end

      it "returns unauthorized status" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

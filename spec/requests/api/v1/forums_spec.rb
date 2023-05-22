require 'rails_helper'

RSpec.describe "Api::V1::Forums", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe "GET /index" do
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

  # describe 'GET /forums/{id}' do
  #   let(:forum) { create(:forum, user: user) }
  #   let(:http_request) { get api_v1_forums_path(forum), headers: headers }

  #   it 'returns forum in json format' do
  #     http_request

  #     expect(body['data'][0]['id']).to eq(forum.id)
  #     expect(response).to be_successful
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end

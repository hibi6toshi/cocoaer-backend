class Api::V1::UsersController < ApplicationController
  def create
    authorize_request = AuthorizationService.new(request.headers)
    user = authorize_request.current_user

    # current_userが取得できない場合、作成後、profileページへ遷移
    # auth0 の loginWithRedirect を使っているせいか元のページに飛ばされるので一旦なし
    user ||= authorize_request.create_user
    # redirect_to api_v1_forums_path, format: :json

    render json: { data: user.as_json }
  end
end

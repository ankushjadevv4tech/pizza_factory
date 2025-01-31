class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def authenticate_user
    token = request.headers['Authorization']
    decoded_token = AuthenticationHelper.decode(token)

    if decoded_token
      @current_user = decoded_token['username']
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end

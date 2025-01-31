class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    user = User.find_by_username(params[:username])
    if user && user.password == params[:password] #Use authenticate method if password encryted
      token = AuthenticationHelper.encode({ username: user.username })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end

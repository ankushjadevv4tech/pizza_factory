require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:valid_user) { User.new('admin', 'password123') }
  let(:invalid_user) { User.new('wronguser', 'wrongpassword') }
  let(:valid_token) { AuthenticationHelper.encode({ username: valid_user.username }) }
  let(:invalid_token) { 'invalid_token' }

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'returns a token' do
        post :login, params: { username: valid_user.username, password: valid_user.password }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an error message' do
        post :login, params: { username: invalid_user.username, password: invalid_user.password }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid username or password')
      end
    end
  end
end

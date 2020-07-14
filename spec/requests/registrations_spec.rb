require 'rails_helper'

RSpec.describe 'Registrations', type: :request do


  # let(:token) do
  #   post '/login', params: { user: { email: user.email, password: user.password } }
  #   response.header['Authorization']
  # end

  describe 'POST /signup' do
    context 'when all parameter are filled' do
      it 'has code 200' do
        post user_registration_path, params: { user: { email: 'teste@test.com', password: '123456', name: 'test-name' }}
        expect(response).to have_http_status(200)
      end

      it 'has body response' do
        post user_registration_path, params: { user: { email: 'teste@test.com', password: '123456', name: 'test-name' }}
        expect(JSON.parse(response.body)
                   .except('created_at', 'updated_at', 'jti')).to eq({ "email" => 'teste@test.com',
                                                                       "id" => 1,
                                                                       "name" => 'test-name' })
      end
    end

    context 'when parameters are incomplete' do
      it 'has status code 200' do
        post user_registration_path, params: { user: { email: 'teste@test.com', password: '123456', name: nil }}
        expect(response).to have_http_status(200)
      end
      it 'has nil name' do
        post user_registration_path, params: { user: { email: 'teste@test.com', password: '123456', name: nil }}
        expect(JSON.parse(response.body)).to eq("name" => ["can't be blank"])
      end
      it 'has nil email' do
        post user_registration_path, params: { user: { email: nil, password: '123456', name: 'test-name' }}
        expect(JSON.parse(response.body)).to eq("email" => ["can't be blank"])
      end
      it 'has nil password' do
        post user_registration_path, params: { user: { email: 'teste@test.com', password: nil, name: 'test-name' }}
        expect(JSON.parse(response.body)).to eq("password" => ["can't be blank"])
      end
    end
  end
end
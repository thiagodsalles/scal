require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { create :user }
  let!(:category) { create :category }

  let(:token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    response.header['Authorization']
  end

  describe 'GET /categories' do
    context 'when not logged in' do
      it 'has error 401' do
        get categories_path
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      it 'has status code 200' do
        get categories_path, headers: { 'Authorization': token }
        expect(response).to have_http_status(200)
      end
      it 'has body with category' do
        get categories_path, headers: { 'Authorization': token }
        expect(JSON.parse(response.body).first.except('created_at', 'updated_at')).to eq(category.as_json.except('created_at', 'updated_at'))
      end
    end
  end

  describe 'GET /categories/:id' do
    context 'when not logged in' do
      it 'has error 401' do
        get category_path(category)
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      it 'has status code 200' do
        get category_path(category), headers: { 'Authorization': token }
        expect(response).to have_http_status(200)
      end
      it 'has body with category' do
        get category_path(category), headers: { 'Authorization': token }
        expect(JSON.parse(response.body).except('created_at', 'updated_at')).to eq(category.as_json.except('created_at', 'updated_at'))
      end
    end
  end

  describe 'POST /categories' do
    context 'when not logged in' do
      it 'has error 401' do
        get categories_path
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      let!(:category) { build :category }
      it 'has status code 200' do
        post categories_path, headers: { 'Authorization': token }, params: { category: { name: category.name } }
        expect(response).to have_http_status(201)
      end
      it 'has body with category' do
        post categories_path, headers: { 'Authorization': token }, params: { category: { name: category.name } }
        expect(JSON.parse(response.body).except('created_at', 'updated_at', 'id')).to eq(category.as_json.except('created_at', 'updated_at', 'id'))
      end
    end
  end
end

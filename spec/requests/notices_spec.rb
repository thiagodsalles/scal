require 'rails_helper'

RSpec.describe 'Notices', type: :request do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:notice) { create :notice, user: user, category: category }
  let(:token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    response.header['Authorization']
  end

  describe 'GET /notices' do
    context 'when not logged in' do
      it 'has error 401' do
        get notices_path
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      context 'with filters' do
        it 'has status code 200' do
          get notices_path, headers: { 'Authorization': token }, params: { category: 1, format: :json }
          expect(response).to have_http_status(200)
        end
        it 'has body with category' do
          get notices_path, headers: { 'Authorization': token }, params: { category: 1, format: :json }
          expect(JSON.parse(response.body)['notices'].first
                     .except('created_at', 'updated_at')).to eq({ "category" => notice.category.name,
                                                                  "id" => notice.id,
                                                                  "imageUrl" => nil,
                                                                  "text" => notice.text,
                                                                  "title" => notice.title,
                                                                  "user" => notice.user.name })
        end
      end

      context 'without filters' do
        it 'has status code 200' do
          get notices_path, headers: { 'Authorization': token }, params: { format: :json }
          expect(response).to have_http_status(200)
        end
        it 'has body with category' do
          get notices_path, headers: { 'Authorization': token }, params: { format: :json }
          expect(JSON.parse(response.body)['notices'].first
                     .except('created_at', 'updated_at')).to eq({ "category" => notice.category.name,
                                                                  "id" => notice.id,
                                                                  "imageUrl" => nil,
                                                                  "text" => notice.text,
                                                                  "title" => notice.title,
                                                                  "user" => notice.user.name })
        end
      end
    end
  end

  describe 'GET /notices/:id' do
    context 'when not logged in' do
      it 'has error 401' do
        get notice_path(notice)
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      it 'has status code 200' do
        get notice_path(notice), headers: { 'Authorization': token }, params: { format: :json }
        expect(response).to have_http_status(200)
      end
      it 'has body with notice' do
        get notice_path(notice), headers: { 'Authorization': token }, params: { format: :json }
        expect(JSON.parse(response.body)['notice']
                   .except('created_at', 'updated_at')).to eq({ "category" => notice.category.name,
                                                                "id" => notice.id,
                                                                "imageUrl" => nil,
                                                                "text" => notice.text,
                                                                "title" => notice.title,
                                                                "user" => notice.user.name })
      end
    end
  end

  describe 'POST /notices' do
    context 'when not logged in' do
      it 'has error 401' do
        get notices_path
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in' do
      let!(:category) { build :category }
      let!(:user) { build :user }

      it 'has status code 200' do
        post notices_path, headers: { 'Authorization': token }, params: { notice: { title: notice.title,
                                                                                    text: notice.text,
                                                                                    user_id: user.id,
                                                                                    category_id: category.id } }
        expect(response).to have_http_status(201)
      end
      it 'has body with notice' do
        post notices_path, headers: { 'Authorization': token }, params: { notice: { title: notice.title,
                                                                                    text: notice.text,
                                                                                    user_id: user.id,
                                                                                    category_id: category.id } }

        expect(JSON.parse(response.body)
                   .except('created_at', 'updated_at', 'id')).to eq({ "category_id" => notice.category.id,
                                                                      "text" => notice.text,
                                                                      "title" => notice.title,
                                                                      "user_id" => notice.user.id })
      end
    end
  end
end


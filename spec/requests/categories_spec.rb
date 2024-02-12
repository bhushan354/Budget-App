require 'rails_helper'

RSpec.describe 'categories', type: :request do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Food', 'icon' => 'missing_avatar.png' } }

  before :each do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    login(@user)
  end

  context 'POST /categories' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'GET /categories' do
    before :each do
      get categories_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'renders the correct content' do
      expect(response.body).to include('ADD CATEGORY')
    end
  end

  context 'GET /categories/new' do
    before :each do
      get new_category_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  def login(user)
    post new_user_session_path, params: {
      user: {
        email: user.email, password: user.password
      }
    }
    follow_redirect!
  end
end

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:category) { Category.create(name: 'Food', icon: 'missing_avatar.png') }
  let(:payment) { Payment.create(name: 'Apples', amount: 5, author: @user) }
  let(:category_payment) { CategoryPayment.create(category: category, payment: payment) }
  let(:valid_attributes) { { 'name' => 'Bananas', 'amount' => 5, 'author' => @user, 'category_ids' => [category.id] } }

  before :each do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    login(@user)
  end

  context 'GET /index' do
    before :each do
      get category_payments_url(:category_id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end
  end

  context 'GET /new' do
    before :each do
      get new_category_payment_url(:category_id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end
  end

  context 'GET /create' do
    it 'returns http redirect response' do
      post category_payments_path(:category_id), params: { payment: valid_attributes }
      expect(response.status).to eq(302)
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

require 'rails_helper'
require 'support/shared_controller_context'

RSpec.describe FriendsController, type: :controller do
  let(:user) { create(:user) }

  context 'without successfully authenticated user' do
    describe '#index' do
      before { get :index }
      it_behaves_like 'a not authenticated request'
    end
  end

  context 'with successfully authenticated user' do
    before { sign_in user }

    describe '#index' do
      before { get :index }
      it_behaves_like 'a successful request'
    end
  end
end

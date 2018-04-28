require 'rails_helper'
require 'support/shared_controller_context'

RSpec.describe FriendRequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  context 'without successfully authenticated user' do
    describe '#create' do
      before { post :create, params: { id: user.id } }
      it_behaves_like 'a not authenticated request'
    end

    describe '#update' do
      before { get :update, params: { id: user.id } }
      it_behaves_like 'a not authenticated request'
    end

    describe '#destroy' do
      before { delete :destroy, params: { id: user.id } }
      it_behaves_like 'a not authenticated request'
    end
  end

  context 'with successfully authenticated user' do
    before { sign_in user }

    context 'with correct parameters' do
      describe '#create' do
        before { post :create, params: { id: friend.id }  }
        it_behaves_like 'a redirected request'
      end

      describe '#update' do
        before { get :update, params: { id: friend.id } }
        it_behaves_like 'a redirected request'
      end

      describe '#destroy' do
        before { delete :destroy, params: { id: friend.id } }
        it_behaves_like 'a redirected request'
      end
    end

    context 'with wrong parameters' do
      before { sign_in user }
      describe '#create' do
        before { post :create, params: { id: 'not valid id' }  }
        it_behaves_like 'a redirected request'
      end

      describe '#update' do
        before { get :update, params: { id: 'not valid id' } }
        it_behaves_like 'a redirected request'
      end

      describe '#destroy' do
        before { delete :destroy, params: { id: 'not valid id' } }
        it_behaves_like 'a redirected request'
      end
    end
  end
end

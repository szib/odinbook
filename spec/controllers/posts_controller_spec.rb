require 'rails_helper'
require 'support/shared_controller_context'
require 'support/posts_controller_helper'

#TODO testing failing current_user, failing actions
RSpec.describe PostsController, type: :controller do
  include_context 'has a few posts'

  describe '#index' do
    context 'when authenticated' do
      include_context 'has an authenticated user'
      before { get :index }
      it_behaves_like 'a successful request'
    end

    context 'when not authenticated' do
      before { get :index }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#new' do
    context 'when authenticated' do
      include_context 'has an authenticated user'
      before { get :new }
      it_behaves_like 'a successful request'
    end

    context 'when not authenticated' do
      before { get :new }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#create' do
    let(:attribs) { attributes_for(:post) }
    context 'when authenticated' do
      include_context 'has an authenticated user'
      before do
        post :create, params: { post: attribs }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when save failed' do
      include_context 'has an authenticated user'
      let(:attribs) { attributes_for(:post, content: '') }
      before { post :create, params: { post: attribs } }
      it_behaves_like 'a successful request'
      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when not authenticated' do
      before { post :create, params: { post: attribs } }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#show' do
    context 'when authenticated' do
      include_context 'has an authenticated user'
      before { get :show, params: { id: first_post.id } }
      it_behaves_like 'a successful request'
    end

    context 'when not authenticated' do
      before { get :show, params: { id: first_post.id } }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#destroy' do
    context 'when authenticated' do
      before do
        sign_in first_post.author
        delete :destroy, params: { id: first_post.id }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when not authorized' do
      before do
        sign_in first_post.author
        delete :destroy, params: { id: second_post.id }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when not authenticated' do
      before { delete :destroy, params: { id: first_post.id } }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#edit' do
    context 'when authenticated' do
      include_context 'has an authenticated user'
      before do
        sign_in first_post.author
        get :edit, params: { id: first_post.id }
      end
      it_behaves_like 'a successful request'
    end

    context 'when not authorized' do
      before do
        sign_in first_post.author
        get :edit, params: { id: second_post.id }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when not authenticated' do
      before { get :edit, params: { id: first_post.id } }
      it_behaves_like 'a not authenticated request'
    end
  end

  describe '#update' do
    let(:attribs) { attributes_for(:post) }
    context 'when authenticated' do
      before do
        sign_in first_post.author
        patch :update, params: { id: first_post.id, post: attribs }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when save failed' do
      let(:attribs) { attributes_for(:post, content: '') }
      before do
        sign_in first_post.author
        patch :update, params: { id: first_post.id, post: attribs }
      end
      it_behaves_like 'a successful request'
      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when not authorized' do
      before do
        sign_in first_post.author
        patch :update, params: { id: second_post.id, post: attribs }
      end
      it_behaves_like 'a redirected request'
    end

    context 'when not authenticated' do
      before { put :update, params: { id: first_post.id, post: attribs } }
      it_behaves_like 'a not authenticated request'
    end
  end

end

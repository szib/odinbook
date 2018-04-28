require 'rails_helper'
require 'support/shared_controller_context'

RSpec.describe StaticPagesController, type: :controller do

  let(:user) { create(:user) }

  context 'without successfully authenticated user' do
    describe '#home' do
      before { get :home }
      it_behaves_like 'a successful request'
    end

    describe '#help' do
      before { get :help }
      it_behaves_like 'a successful request'
    end
  end

  context 'with successfully authenticated user' do
    before { sign_in user }

    describe '#home' do
      before { get :home }
      it_behaves_like 'a successful request'
    end

    describe '#help' do
      before { get :help }
      it_behaves_like 'a successful request'
    end
  end


end

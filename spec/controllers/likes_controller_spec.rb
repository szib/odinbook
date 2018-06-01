require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe LikesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Like. As you add validations to Like, be sure to
  # adjust the attributes here as well.
  before { sign_in user }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LikesController. Be sure to keep this updated too.

  shared_examples 'a likeable object' do
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Like" do
          expect {
            post :create, params: valid_attributes
          }.to change(Like, :count).by(1)
        end

        it "redirects back" do
          post :create, params: valid_attributes
          expect(response).to redirect_to(root_path)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          expect{
            post :create, params: invalid_attributes
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested like" do
        expect {
          delete :destroy, params: valid_attributes
        }.to change(Like, :count).by(-1)
      end

      it "redirects to the likes list" do
        delete :destroy, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'a post' do
    let(:a_post) { create(:post) }
    let(:user) { create(:user) }
    let!(:like) { create(:like, likeable: a_post, user: user) }
    it_behaves_like 'a likeable object' do
      let(:valid_attributes) {
        { post_id: a_post.id }
      }
      let(:invalid_attributes) {
        { post_id: 'no_id' }
      }
    end
  end

  describe 'a comment' do
    let(:a_comment) { create(:comment) }
    let(:user) { create(:user) }
    let!(:like) { create(:like, likeable: a_comment, user: user) }
    it_behaves_like 'a likeable object' do
      let(:valid_attributes) {
        { comment_id: a_comment.id }
      }
      let(:invalid_attributes) {
        { comment_id: 'no_id' }
      }
    end
  end


end
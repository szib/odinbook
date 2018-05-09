require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:a_post) { create(:post) }
  let(:a_comment) { create(:comment) }

  describe "POST /posts/:post_id/like" do
    it "works" do
      post post_like_path(a_post.id)
      expect(response).to have_http_status(302)
    end
  end
  describe "DELETE /posts/:post_id/like" do
    it "works" do
      create(:like, likeable: a_post)
      delete post_like_path(a_post.id)
      expect(response).to have_http_status(302)
    end
  end
  describe "POST /comments/:comment_id/like" do
    it "works" do
      post comment_like_path(a_comment.id)
      expect(response).to have_http_status(302)
    end
  end
  describe "DELETE /comments/:comment_id/like" do
    it "works" do
      create(:like, likeable: a_comment)
      delete comment_like_path(a_comment.id)
      expect(response).to have_http_status(302)
    end
  end
end

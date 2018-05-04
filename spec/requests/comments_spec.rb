require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:a_comment) { create(:comment) }
  describe "GET /posts/:post_id/comments/new" do
    it "works" do
      get new_post_comment_path({ post_id: a_comment.post.id})
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /posts/:post_id/comments" do
    it "works" do
      post post_comments_path({ post_id: a_comment.post.id})
      expect(response).to have_http_status(302)
    end
  end
  describe "DELETE /posts/:post_id/comments/:id" do
    it "works" do
      delete post_comment_path({ post_id: a_comment.post.id, id: a_comment.id})
      expect(response).to have_http_status(302)
    end
  end
end

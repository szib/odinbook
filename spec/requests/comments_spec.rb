require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:a_comment) { create(:comment) }
  describe "POST /posts/:post_id/comments" do
    it "works" do
      post post_comments_path({ post_id: a_comment.post.id})
      expect(response).to have_http_status(302)
    end
  end
end

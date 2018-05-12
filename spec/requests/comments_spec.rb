require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:a_post) { create(:post) }
  let(:a_comment) { attributes_for(:comment) }
  describe "POST /posts/:post_id/comments" do
    it "works" do
      post post_comments_path( post_id: a_post.id, comment: a_comment)
      expect(response).to have_http_status(302)
    end
  end
end

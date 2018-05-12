require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "post like routing" do

    it "routes to #create" do
      expect(:post => "/posts/1/like").to route_to("likes#create", post_id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/posts/1/like").to route_to("likes#destroy", post_id: "1")
    end

  end

  describe "comment like routing" do

    it "routes to #create" do
      expect(:post => "/comments/1/like").to route_to("likes#create",  comment_id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/comments/1/like").to route_to("likes#destroy", comment_id: "1")
    end

  end
end

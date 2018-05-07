require 'rails_helper'

RSpec.describe LikesHelper, type: :helper do
  it 'works if nobody liked the post' do
    expect(like_sentence(0)).to match 'Nobody likes this post.'
  end
  it 'works if 1 person liked the post' do
    expect(like_sentence(1)).to match '1 person likes this post.'
  end
  it 'works if more people liked the post' do
    expect(like_sentence(6)).to match '6 people like this post.'
  end
  it 'return empty string for negative' do
    expect(like_sentence(-5)).to be_empty
  end
end

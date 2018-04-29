RSpec.shared_context 'has a user' do
  let(:user) { create(:user) }
end

RSpec.shared_context 'has an authenticated user' do
  let(:user) { create(:user) }
  before { sign_in user }
end

RSpec.shared_context 'has a few posts' do
  let(:posts) { create_list(:post, 10) }
  let(:first_post) { posts.first }
end

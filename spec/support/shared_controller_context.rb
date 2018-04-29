
RSpec.shared_context 'a successful request' do
  it 'returns an OK (200) status code' do
    expect(response.status).to eq(200)
  end
end

RSpec.shared_context 'a redirected request' do
  it 'returns an FOUND (302) status code' do
    expect(response.status).to eq(302)
  end
end

RSpec.shared_context 'a not authenticated request' do
  it 'redirects to sign in page' do
    expect(response.status).to eq(302)
    expect(response).to redirect_to :new_user_session
  end
end

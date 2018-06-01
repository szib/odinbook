require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe 'wecome mail' do
    let(:recipient) { create(:user) }
    let(:welcome_mail) { UserMailer.with(user: recipient).welcome_mail }

    it 'has a correct recipient address' do
      expect(welcome_mail.to).to eq [recipient.email]
    end

    it 'renders the body' do
      expect(welcome_mail.body.encoded).to match "Welcome to Odinbook"
      expect(welcome_mail.body.encoded).to match recipient.profile.full_name
      expect(welcome_mail.body.encoded).to match "localhost"
    end
  end
end

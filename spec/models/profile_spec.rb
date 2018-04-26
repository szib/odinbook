require 'rails_helper'

RSpec.describe Profile, type: :model do
  include FactoryBot::Syntax::Methods

  subject(:profile_without_user) { build(:profile) }
  subject(:profile_with_user) { build(:user).profile }

  describe 'validity' do
    it 'should be valid' do
      expect(profile_with_user).to be_valid
    end

    it 'should be invalid without associated user' do
      expect(profile_without_user).to_not be_valid
    end

    it 'should be invalid without first name' do
      profile_with_user.first_name = nil
      expect(profile_with_user).to_not be_valid
    end

    it 'should be invalid without last name' do
      profile_with_user.last_name = nil
      expect(profile_with_user).to_not be_valid
    end

    it 'should be valid without location' do
      profile_with_user.location = nil
      expect(profile_with_user).to be_valid
    end
  end

  it 'should return full name' do
    full_name = "#{profile_with_user.first_name} #{profile_with_user.last_name}"
    expect(profile_with_user.full_name).to eq(full_name)
  end

  it 'should capitalize names' do
    user = build(:user)
    user.profile.first_name = 'lower'
    user.profile.last_name = 'case'
    user.save
    expect(user.profile.first_name).to eq('Lower')
    expect(user.profile.last_name).to eq('Case')
  end
end

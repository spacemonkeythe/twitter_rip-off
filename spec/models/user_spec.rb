require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:password_digest).of_type(:string) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value("example@example.com", "example.example@example.com",
   "A_US-ER@f.b.org", "a+b@baz.cn").for(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }
  it { is_expected.to validate_presence_of(:password_confirmation) }

  describe ".create_remember_token" do
    before do
      @user = double(User)
      allow(@user).to receive(:remember_token=)
      allow(SecureRandom).to receive(:urlsafe_base64) { "ENkIvnCGzAN0YI3KEMIAWA" }
    end

    it "creates remember_token" do
      expect(@user.remember_token = SecureRandom.urlsafe_base64).to eql("ENkIvnCGzAN0YI3KEMIAWA")
    end
  end

  describe "remember" do
    before do
      @user = double(User)
      allow(@user).to receive(:remember_token=)
      allow(User).to receive(:new_token) { "ENkIvnCGzAN0YI3KEMIAWA" }
      allow(User).to receive(:digest).with(:remember_token) { "ENkIvnCGzAN0YI3KEMIAWAENkIvnCGzAN0YI3KEMIAWAENkIvnCGzAN0YI3KEMIAWA" }
      allow(@user).to receive(:update_attribute).with(:remember_digest, User.digest(:remember_token)) { true }
    end

    it "remembers the token" do
      expect(@user.update_attribute(:remember_digest, User.digest(:remember_token))).to eql(true)
    end
  end

  describe ".forget" do
    before do
      @user = double(User)
      allow(@user).to receive(:update_attribute).with(:remember_digest, nil) { true }
    end

    it "forgets the token" do
      expect(@user.update_attribute(:remember_digest, nil)).to eql(true)
    end
  end

end

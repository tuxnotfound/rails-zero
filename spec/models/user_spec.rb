require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:provider_uid) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  end

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: "github",
        uid: "12345",
        info: { nickname: "testuser", name: "Test User", email: "test@example.com", image: "https://example.com/avatar.png" },
        credentials: { token: "gho_token" }
      )
    end

    it "creates a new user from auth hash" do
      user = User.from_omniauth(auth)
      expect(user.provider).to eq("github")
      expect(user.provider_uid).to eq("12345")
      expect(user.username).to eq("testuser")
      expect(user.name).to eq("Test User")
    end

    it "finds an existing user" do
      existing = create(:user, provider: "github", provider_uid: "12345")
      user = User.from_omniauth(auth)
      expect(user).to eq(existing)
    end
  end

  describe "#soft_delete!" do
    it "sets deleted_at" do
      user = create(:user)
      expect { user.soft_delete! }.to change { user.deleted_at }.from(nil)
    end
  end

  describe "#deleted?" do
    it "returns false when not deleted" do
      expect(user.deleted?).to be false
    end

    it "returns true when deleted_at is set" do
      user.deleted_at = Time.current
      expect(user.deleted?).to be true
    end
  end

  describe ".active scope" do
    it "excludes soft-deleted users" do
      active  = create(:user)
      deleted = create(:user, deleted_at: Time.current)
      expect(User.active).to include(active)
      expect(User.active).not_to include(deleted)
    end
  end
end

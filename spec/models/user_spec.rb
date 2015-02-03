require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:email).of_type(:string) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value("example@example.com", "example.example@example.com",
   "A_US-ER@f.b.org", "a+b@baz.cn").for(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }

end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |count| "Name_#{count}" }
    sequence(:email) { |count| "test_#{count}@email.com" }
    password "testpassword"
    password_confirmation "testpassword"

    trait :admin do
      admin true
    end
  end
end

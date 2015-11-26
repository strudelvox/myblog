FactoryGirl.define do

  factory :user do

    password "12345678"

    status 1
    notifications 0
    message ""

    factory :editor do
      sequence(:first_name) { |n| "user#{n}_myFirstName" }
      sequence(:last_name) { |n| "user#{n}_myLastName" }
      sequence(:email) { |n| "user#{n}@example.com" }
      role 0
    end

    factory :admin do
      sequence(:first_name) { |n| "admin#{n}_myFirstName" }
      sequence(:last_name) { |n| "admin#{n}_myLastName" }
      sequence(:email) { |n| "admin#{n}@example.com" }
      role 1
    end

    trait :banned do
      status 0
    end

    trait :active do
      status 1
    end

    after(:create) do |user|
      user.skip_confirmation!
      user.save!
      user.confirm!
    end

  end

end
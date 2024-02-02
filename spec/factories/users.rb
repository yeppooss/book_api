FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    trait :admin do
      role { :admin }
    end

    trait :consumer do
      role { :consumer }
    end

    trait :with_book do
      after(:create) do |user|
        create(:book, user_id: user.id)
      end
    end
  end
end
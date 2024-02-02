FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.sentence(word_count: 10) }

    association :user
  end
end
FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end

  factory :invalid_question, class: 'Question' do
    title 'short'
    body ''
  end
end

FactoryGirl.define do
  factory :question do
    title 'Description of question'
    body 'Extended information about question'
  end

  factory :invalid_question, class: 'Question' do
    title 'short'
    body ''
  end
end

FactoryGirl.define do

  factory :recording do

    association :user, factory: :editor

    sequence(:rec_header) { |n| "Heading header heads so: header_#{n}" }
    sequence(:rec_teaser) { |n| "tease it: teaser_#{n}" }
    sequence(:rec_text) { |n| "txt now is: text_#{n} text1_#{n+n} text2_#{n*n}" }
    sequence(:created_at) { |n| DateTime.strptime("09/14/2009 8:00","%m/%d/%Y %H:%M")+n.days }
    rec_approved 1

    trait :not_approved do
      rec_approved 0
    end

    trait :approved do
      rec_approved 1
    end

  end

end
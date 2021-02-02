FactoryBot.define do
  sequence :latitude do |n|
    "-71.00#{n}".to_f
  end

  sequence :longitude do |n|
    "42.65#{n}".to_f
  end

  factory :hydrant do
    name { Faker::Name.name }
    coordinates { "POINT(#{generate(:longitude)} #{generate(:latitude)})" }
    hydrant_type { "dry" }

    trait :tested do
      last_tested_at  { 1.week.ago }
    end
  end
end

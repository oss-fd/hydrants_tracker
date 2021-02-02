FactoryBot.define do
  sequence :engine_name do |x|
    "Engine #{x}"
  end

  factory :apparatus do
    name { generate(:engine_name) }
  end
end

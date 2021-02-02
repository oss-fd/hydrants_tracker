FactoryBot.define do
  factory :hydrant_check do
    hydrant
    line_used { "2 1/2" }
    minutes_pumped { (1..10).to_a.sample }
    apparatus { create(:apparatus) }
    pump_operator { create(:pump_operator) }
  end
end

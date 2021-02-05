require 'rails_helper'

RSpec.describe "Api::Everythings", type: :request do

  before do
    3.times { FactoryBot.create(:pump_operator) }
    3.times { FactoryBot.create(:apparatus) }
    3.times { FactoryBot.create(:hydrant, hydrant_type: %w(dry wet tank).sample) }
    Hydrant.all.each do |hydrant|
      3.times do
        FactoryBot.create(
          :hydrant_check,
          hydrant: hydrant,
          pump_operator: PumpOperator.all.sample,
          apparatus: Apparatus.all.sample
        )
      end
    end
  end

  describe "GET /show" do
    it "returns everything — all hydrants, checks, apparatus, and pump operators" do
      get "/api/everything", as: :json
      json = JSON.parse(response.body)
      expect(json["pump_operators"].length).to eq 3
      expect(json["apparatus"].length).to eq 3
      expect(json["hydrants"].length).to eq 3
      expect(json["hydrant_checks"].length).to eq 9
    end

    it "excludes discarded records" do
      [PumpOperator, Apparatus, Hydrant, HydrantCheck].each { |klass| klass.all.sample.discard! }

      get "/api/everything", as: :json
      json = JSON.parse(response.body)
      expect(json["pump_operators"].length).to eq 2
      expect(json["apparatus"].length).to eq 2
      expect(json["hydrants"].length).to eq 2
      expect(json["hydrant_checks"].length).to eq 8
    end
  end
end

require 'rails_helper'

RSpec.describe "Api::HydrantChecks", type: :request do

  before do
    @hydrant = FactoryBot.create(:hydrant)
    @pump_operator = FactoryBot.create(:pump_operator)
    @apparatus = FactoryBot.create(:apparatus)
  end

  describe "POST /create" do
    it "saves with good params" do
      post "/api/hydrant_checks", params: { hydrant_id: @hydrant.id, hydrant_check: check_params }, as: :json

      json = JSON.parse(response.body)
      expect(json["status"]).to eq "ok"
      expect(json["hydrant_check"]["hydrant_id"]).to eq @hydrant.id
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(response).to have_http_status(200)
    end

    it "does not save with bad params" do
      post "/api/hydrant_checks", params: { hydrant_id: @hydrant.id, hydrant_check: check_params.except(:apparatus_id) }, as: :json

      json = JSON.parse(response.body)
      expect(json["status"]).to eq "error"
      expect(json["flash"]["error"]).to eq "Apparatus must exist, Apparatus can't be blank"
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(response).to have_http_status(422)
    end
  end

  def check_params
    {
      "tank_locked":true,
      "vegetation_overgrown":true,
      "lock_operable":true,
      "prime_pulled":true,
      "circulated":true,
      "line_used":"3",
      "minutes_pumped":5,
      "in_service":true,
      "notes":"yup",
      "pump_operator_id": @pump_operator.id,
      "apparatus_id": @apparatus.id,
      "needs_follow_up":true
    }
  end
end

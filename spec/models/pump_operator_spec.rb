require 'rails_helper'

RSpec.describe PumpOperator, type: :model do
  describe "validations" do
    it "requires a name" do
      pump_operator = FactoryBot.build(:pump_operator, name: nil)
      expect(pump_operator.valid?).to be false
    end
  end
end

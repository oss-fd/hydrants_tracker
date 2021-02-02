require 'rails_helper'

RSpec.describe HydrantCheck, type: :model do
  describe "validations" do
    context "on #notes" do
      it "required if the hydrant_check is taking a hydrant out of service" do
        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, in_service: false)

        check.valid?

        expect(check.errors[:notes]).to be_present
      end

      it "not required if the hydrant check leaving hydrant in service" do
        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant)

        check.valid?

        expect(check.errors[:notes]).to be_empty
      end
    end

    context "on #line_used" do
      it "required if hydrant is a tank" do
        hydrant = FactoryBot.create(:hydrant, hydrant_type: "tank")
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, line_used: nil)

        expect(check.valid?).to be_falsey
        expect(check.errors[:line_used]).to be_present
      end

      it "not required if hydrant is not a tank" do
        hydrant = FactoryBot.create(:hydrant, hydrant_type: "dry")
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, line_used: nil)

        expect(check.valid?).to be_truthy
        expect(check.errors[:line_used]).to be_empty
      end

      it "prohibits invalid values (thanks enum!)" do
        expect {
          FactoryBot.build(:hydrant_check,
            hydrant:  FactoryBot.create(:hydrant, hydrant_type: "tank"),
            line_used: "herp"
          )
        }.to raise_error(ArgumentError)
      end
    end

    context "on #minutes_pumped" do
      it "is required" do
        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, minutes_pumped: nil)

        expect(check.valid?).to be_falsey
        expect(check.errors[:minutes_pumped]).to be_present
      end

      it "is required to be a number regardless of the check's in_service" do
        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, minutes_pumped: "one")

        expect(check.valid?).to be_falsey
        expect(check.errors[:minutes_pumped]).to be_present

        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, minutes_pumped: "one", in_service: false)

        expect(check.valid?).to be_falsey
        expect(check.errors[:minutes_pumped]).to be_present
      end

      it "is not required if the hydrant is being marked out of service" do
        hydrant = FactoryBot.create(:hydrant)
        check = FactoryBot.build(:hydrant_check, hydrant: hydrant, minutes_pumped: nil, in_service: false, notes: "something bad happened")

        expect(check.valid?).to be_truthy
        expect(check.errors[:minutes_pumped]).to be_empty
      end
    end
  end
end

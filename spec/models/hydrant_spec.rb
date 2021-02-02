require 'rails_helper'

RSpec.describe Hydrant, type: :model do
  describe "validations" do
    context "on #name" do
      it "is required" do
        hydrant = FactoryBot.build(:hydrant, name: nil)

        expect(hydrant.valid?).to be_falsey
        expect(hydrant.errors[:name]).to be_present
      end
    end

    context "on #hydrant_type" do
      it "is required" do
        hydrant = FactoryBot.build(:hydrant, hydrant_type: nil)

        expect(hydrant.valid?).to be_falsey
        expect(hydrant.errors[:hydrant_type]).to be_present
      end

      it "needs to be in the list of allowed types" do
        expect {
          FactoryBot.build(:hydrant, hydrant_type: "evil")
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#out_of_service?" do
    it "is true if the hydrant is marked as out of service" do
      hydrant = FactoryBot.create(:hydrant, in_service: false)
      expect(hydrant.out_of_service?).to eq(true)
    end

    it "is false if the pump has been tested and is marked as in service" do
      hydrant = FactoryBot.create(:hydrant, last_tested_at: Time.now.utc)
      expect(hydrant.out_of_service?).to eq(false)
    end
  end

  describe "#needs_testing?" do
    it "is true if the hydrant was last tested over two years ago" do
      hydrant = FactoryBot.create(:hydrant, last_tested_at: 3.years.ago.utc)
      expect(hydrant.needs_testing?).to eq(true)
    end

    it "is true if the hydrant was marked as needing testing" do
      hydrant = FactoryBot.create(:hydrant, :tested, needs_follow_up: 1.week.from_now)
      expect(hydrant.needs_testing?).to eq(true)
    end
  end
end

require 'rails_helper'

RSpec.describe Apparatus, type: :model do
  describe "validations" do
    it "requires a name" do
      apparatus = FactoryBot.build(:apparatus, name: nil)
      expect(apparatus.valid?).to be false
    end
  end
end

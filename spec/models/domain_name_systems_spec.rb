require 'rails_helper'

RSpec.describe DomainNameSystem, type: :model do
  describe "Validations" do
    describe "Database" do
      it { is_expected.to have_db_column(:ip).of_type(:string).with_options(null: false, unique: true) }
    end
    describe "Relationships" do
      it { should have_and_belong_to_many(:hostname) }
    end
  end
end
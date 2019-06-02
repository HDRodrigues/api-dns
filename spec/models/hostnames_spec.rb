require 'rails_helper'

RSpec.describe Hostname, type: :model do
  describe "Validations" do
    describe "Database" do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false, unique: true) }
    end

    describe "Relationships" do
      it { should have_and_belong_to_many(:domain_name_system) }
    end
  end
end
require 'rails_helper'

RSpec.describe DomainNameSystem, type: :model do
  describe "Validations" do
    subject { described_class.create(ip: '1.1.1.1') }

    it { is_expected.to validate_presence_of(:ip) }
    it { is_expected.to validate_uniqueness_of(:ip).case_insensitive }
  end

  describe "Relationships" do
    it { is_expected.to have_and_belong_to_many(:hostnames) }
  end
end
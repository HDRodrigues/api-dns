require 'rails_helper'

RSpec.describe Hostname, type: :model do
  describe "Validations" do
    subject { described_class.create(name: 'Foo') }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "Relationships" do
    it { is_expected.to have_and_belong_to_many(:domain_name_systems) }
  end
end
class Hostname < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :domain_name_systems, -> { distinct }

  scope :with_names, ->(names) { where(name: names) }
end
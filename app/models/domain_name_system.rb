class DomainNameSystem < ActiveRecord::Base
  validates :ip, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :hostnames, -> { distinct }

  scope :in_hostnames, ->(hostnames) { in_hostnames(hostnames) }
  scope :not_in_hostnames, ->(hostnames) { joins(:hostnames).merge(Hostname.with_names(hostnames)).distinct }
  scope :blacklist, ->(blocked_ids) { where.not(id: blocked_ids).order(:id) }

  def self.in_hostnames(hostnames)
    base_query = joins(:hostnames)
    base_query = base_query.merge(Hostname.with_names(hostnames)) if hostnames.present?
    base_query.distinct
  end
end
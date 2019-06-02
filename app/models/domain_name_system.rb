class DomainNameSystem < ActiveRecord::Base
	validates :ip, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :hostnames
end
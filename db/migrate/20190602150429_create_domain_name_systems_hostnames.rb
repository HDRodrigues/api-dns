class CreateDomainNameSystemsHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_name_systems_hostnames do |t|
      t.belongs_to :hostname, index: true
      t.belongs_to :domain_name_system, index: true
    end
  end
end

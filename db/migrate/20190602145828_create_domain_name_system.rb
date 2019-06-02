class CreateDomainNameSystem < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_name_systems do |t|
      t.string :ip, null: false, unique: true
    end
  end
end

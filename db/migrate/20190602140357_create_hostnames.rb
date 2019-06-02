class CreateHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :hostnames do |t|
      t.string :name, null: false, unique: true
    end
  end
end

class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, index: true
      t.string :last_name, index: true
      t.string :phone, index: true

      t.timestamps null: false
    end
  end
end

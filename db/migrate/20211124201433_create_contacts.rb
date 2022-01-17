class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.text :name
      t.text :email
      t.text :phone
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateDrugs < ActiveRecord::Migration[7.0]
  def change
    create_table :drugs do |t|
      t.string :registration_no, null: false
      t.string :name, null: false

      t.timestamps
    end
    
    add_index :drugs, :registration_no, unique: true
  end
end

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :drug, null: false, foreign_key: true
      t.references :workplace, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, [:drug_id, :workplace_id], unique: true 
  end
end

class CreateWorkplaces < ActiveRecord::Migration[7.0]
  def change
    create_table :workplaces do |t|
      t.string :name, null: false
      t.string :address
      t.string :tax_code
      t.text :description
      t.string :slug

      t.timestamps
    end
    
    add_index :workplaces, :tax_code, unique: true
  end
end

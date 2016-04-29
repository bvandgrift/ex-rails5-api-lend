class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :olid
      t.text :bio

      t.timestamps
    end
    add_index :authors, :olid, unique: true
  end
end

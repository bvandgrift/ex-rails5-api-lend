class CreateTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :titles do |t|
      t.string :title
      t.string :olid

      t.timestamps
    end
    add_index :titles, :olid, unique: true
  end
end

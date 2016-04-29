class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.references :title, foreign_key: true

      t.timestamps
    end
  end
end

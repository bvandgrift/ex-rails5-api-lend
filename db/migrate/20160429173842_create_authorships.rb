class CreateAuthorships < ActiveRecord::Migration[5.0]
  def change
    create_table :authorships do |t|
      t.references :author, foreign_key: true
      t.references :title, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSectionAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :section_assignments do |t|
      t.references :title, foreign_key: true
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end

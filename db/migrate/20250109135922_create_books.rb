class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false # No index since less data
      t.string :class_name         # No index since less data
      t.string :medium
      t.string :year               # No index since less data
      t.string :pdf_path           # Path to the PDF file
      t.text :content              # Stores book content (large text)
      t.timestamps
    end
  end
end

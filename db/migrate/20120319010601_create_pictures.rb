class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string     :pic
      t.string     :slug
      t.text       :caption
      t.references :album

      t.timestamps
    end
    add_index :pictures, :slug
  end
end

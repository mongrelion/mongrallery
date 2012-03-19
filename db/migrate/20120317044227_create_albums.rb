class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string  :name
      t.text    :description
      t.boolean :public, default: true
      t.timestamps
    end
  end
end

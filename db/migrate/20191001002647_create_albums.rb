class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :genre
      t.integer :year

      t.timestamps
    end
  end
end

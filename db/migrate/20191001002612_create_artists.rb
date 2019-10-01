class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.boolean :is_local?
      t.integer :album_id

      t.timestamps
    end
  end
end

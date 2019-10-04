class AddImgColumnToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :album_img, :string
  end
end
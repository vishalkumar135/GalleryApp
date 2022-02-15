class AddPublishedToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :published, :boolean 
  end
end

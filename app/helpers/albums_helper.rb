module AlbumsHelper
  def album_cover(album)
    image = image_path 'icon-folder.png'
    image = album.pictures.first.pic.url(:thumb) if album.pictures.any?
    image_tag image, size: '120x160'
  end
end

class PicturesController < InheritedResources::Base
  before_filter :load_albums, except: [:index, :destroy]

  def gallery
    @pictures  = Picture.all
    render 'index'
  end

  private

    def load_albums
      @albums = Album.order 'name ASC'
    end
end

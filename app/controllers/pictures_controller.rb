class PicturesController < InheritedResources::Base
  before_filter :authorize!,  except: [:index, :show]
  before_filter :load_albums, except: [:index, :destroy]

  private

    def load_albums
      @albums = Album.all
    end
end

class PicturesController < InheritedResources::Base
  before_filter :authorize!,  :except => [:index, :show]
  before_filter :load_albums, :except => [:index, :show, :destroy]

  def show
    @picture = Picture.find params[:id]
    unless user_signed_in?
      not_found unless @picture.is_public?
    end
  end

  protected

    def collection
      if user_signed_in?
        super
      else
        @pictures = Picture.public_pics
      end
    end

    def load_albums
      @albums = Album.all
    end
end
